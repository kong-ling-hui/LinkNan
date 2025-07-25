package lntest.top

import chisel3._
import chisel3.util._

class LuaScoreboard(l2Str:String, nrHnf:Int) extends BlackBox(
  Map(
    "L2_CFG_STR" -> l2Str,
    "NR_HNF" -> nrHnf
  )
) with HasBlackBoxInline {
  val io = IO(new Bundle {
    val clock = Input(Clock())
    val reset = Input(Bool())
    val sim_final = Input(Bool())
  })
  setInline(s"LuaScoreboard.sv",
    s"""
       |module LuaScoreboard #(
       |  parameter string L2_CFG_STR,
       |  parameter NR_HNF
       |)(
       |  input  wire clock,
       |  input  wire reset,
       |  input  wire sim_final
       |);
       |`ifndef SYNTHESIS
       |  import "DPI-C" function void verilua_final();
       |  import "DPI-C" function void verilua_main_step_safe();
       |
       |`ifdef MANUALLY_CALL_DPI_EXPORTER_TICK
       |`ifdef DECL_DPI_EXPORTER_TICK
       |`DECL_DPI_EXPORTER_TICK
       |`endif // DECL_DPI_EXPORTER_TICK
       |`endif // MANUALLY_CALL_DPI_EXPORTER_TICK
       |
       |always @ (negedge clock) begin
       |  if(~reset) begin
       |`ifdef MANUALLY_CALL_DPI_EXPORTER_TICK
       |`ifdef CALL_DPI_EXPORTER_TICK
       |`CALL_DPI_EXPORTER_TICK
       |`endif // CALL_DPI_EXPORTER_TICK
       |`endif // MANUALLY_CALL_DPI_EXPORTER_TICK
       |  end
       |  // if(~reset) verilua_main_step_safe();
       |  if(sim_final) verilua_final();
       |end
       |
       |`ifndef VERILATOR
       |final verilua_final();
       |`endif // VERILATOR
       |
       |`endif // SYNTHESIS
       |endmodule
       |
       |""".stripMargin)
}
