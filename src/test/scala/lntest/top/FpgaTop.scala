package lntest.top

import chisel3.{BlackBox, _}
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util.HasBlackBoxInline
import linknan.generator.{AddrConfig, Generator}
import linknan.soc.{LNTop, LinkNanParamsKey}
import org.chipsalliance.cde.config.Parameters
import org.chipsalliance.diplomacy.DisableMonitors
import xs.utils.{FileRegisters, ResetGen}
import xs.utils.perf.DebugOptionsKey
import xs.utils.stage.XsStage
import zhujiang.{NocIOHelper, ZJParametersKey, ZJRawModule}
import zhujiang.axi.{AxiBufferChain, AxiBundle, AxiUtils, ExtAxiBundle}

class VerilogAddrRemapper(width:Int) extends BlackBox with HasBlackBoxInline {
  val io = IO(new Bundle {
    val a = Input(UInt(width.W))
    val b = Input(UInt(width.W))
    val c = Input(UInt(width.W))
    val z = Output(UInt(width.W))
  })
  setInline(s"VerilogAddrRemapper.sv",
    s"""module VerilogAddrRemapper (
       |  input  wire [${width - 1}:0] a,
       |  input  wire [${width - 1}:0] b,
       |  input  wire [${width - 1}:0] c,
       |  output wire [${width - 1}:0] z
       |);
       |  assign z = a - b + c;
       |endmodule""".stripMargin)
}

class FpgaClkDiv10 extends BlackBox with HasBlackBoxInline {
  val io = IO(new Bundle {
    val CK = Input(Clock())
    val Q = Output(Clock())
  })
  setInline(s"FpgaClkDiv10.sv",
    s"""module FpgaClkDiv10 (
       |  input  wire CK,
       |  output wire Q
       |);
       |  reg  [3:0]   div_reg;
       |  reg          rtc_reg;
       |`ifndef SYNTHESIS
       |  initial div_reg = 0;
       |  initial rtc_reg = 0;
       |`endif
       |  always @(posedge CK) begin
       |    if (div_reg > 4'h8) begin
       |      div_reg <= 4'h0;
       |    end else begin
       |      div_reg <= div_reg + 4'h1;
       |    end
       |    rtc_reg <= div_reg > 4'h4;
       |  end
       |  assign Q = rtc_reg;
       |endmodule""".stripMargin)
}

object VerilogAddrRemapper {
  def apply(a:UInt, b:UInt, c:UInt):UInt = {
    val rmp = Module(new VerilogAddrRemapper(a.getWidth.max(b.getWidth)))
    rmp.io.a := a
    rmp.io.b := b
    rmp.io.c := c
    rmp.io.z
  }
}

class FpgaTop(implicit p: Parameters) extends ZJRawModule with NocIOHelper with ImplicitClock with ImplicitReset {
  override val desiredName = "XlnFpgaTop"
  private val soc = Module(new LNTop)
  val io = IO(new Bundle {
    val aresetn = Input(Bool())
    val aclk = Input(Clock())
    val core_clk = Input(Vec(soc.io.cluster_clocks.size, Clock()))
    val rtc_clk = Input(Clock())
    val reset_vector = Input(UInt(raw.W))
    val ddr_offset = Input(UInt(raw.W))
    val ext_intr = Input(UInt(soc.io.ext_intr.getWidth.W))
  })
  private val _reset = (!io.aresetn).asAsyncReset
  private val resetSync = withClockAndReset(io.aclk, _reset) { ResetGen(2, None) }
  val implicitClock = io.aclk
  val implicitReset = resetSync

  private val rtc_div = Module(new FpgaClkDiv10)
  rtc_div.io.CK := io.rtc_clk

  soc.io.cluster_clocks := io.core_clk
  soc.io.noc_clock := io.aclk
  soc.io.rtc_clock := rtc_div.io.Q.asBool
  soc.io.ext_intr := io.ext_intr
  soc.io.default_reset_vector := io.reset_vector
  soc.io.reset := resetSync
  soc.io.dft := DontCare
  soc.io.ramctl := DontCare
  soc.io.ci := 0.U
  soc.io.dft.lgc_rst_n := true.B
  soc.io.jtag.foreach(_ := DontCare)
  soc.io.jtag.foreach(_.reset := true.B.asAsyncReset)
  soc.dmaIO.foreach(_ := DontCare)

  val ddrDrv = soc.ddrIO.map(AxiUtils.getIntnl)
  val cfgDrv = soc.cfgIO.map(AxiUtils.getIntnl)
  val dmaDrv = Seq()
  val ccnDrv = Seq()
  val hwaDrv = soc.hwaIO.map(AxiUtils.getIntnl)
  runIOAutomation()
  ddrIO.zip(ddrDrv).foreach({case(a, b) =>
    a.araddr := VerilogAddrRemapper(b.ar.bits.addr, AddrConfig.pmemRange.lower.U(raw.W), io.ddr_offset)
    a.awaddr := VerilogAddrRemapper(b.aw.bits.addr, AddrConfig.pmemRange.lower.U(raw.W), io.ddr_offset)
  })
}

object FpgaGenerator extends App {
  val (config, firrtlOpts) = SimArgParser(args)
  xs.utils.GlobalData.prefix = config(LinkNanParamsKey).prefix
  difftest.GlobalData.prefix = config(LinkNanParamsKey).prefix
  (new XsStage).execute(firrtlOpts, Generator.firtoolOpts ++ Seq(
    ChiselGeneratorAnnotation(() => {
      DisableMonitors(p => new FpgaTop()(p))(config.alter((site, here, up) => {
        case DebugOptionsKey => up(DebugOptionsKey).copy(EnableDifftest = false)
      }))
    })
  ))
  FileRegisters.write(filePrefix = config(LinkNanParamsKey).prefix + "LNTop.")
}