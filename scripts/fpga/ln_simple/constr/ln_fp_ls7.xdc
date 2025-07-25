

create_pblock pblock_cc
add_cells_to_pblock [get_pblocks pblock_cc] [get_cells -quiet [list ln_simple_i/ln/inst/soc/cc_0]]
resize_pblock [get_pblocks pblock_cc] -add {SLR0:SLR1}
create_pblock pblock_hnf_0
add_cells_to_pblock [get_pblocks pblock_hnf_0] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/hnf_0]]
resize_pblock [get_pblocks pblock_hnf_0] -add {CLOCKREGION_X3Y11:CLOCKREGION_X6Y12}
create_pblock pblock_hnf_1
add_cells_to_pblock [get_pblocks pblock_hnf_1] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/hnf_1]]
resize_pblock [get_pblocks pblock_hnf_1] -add {CLOCKREGION_X3Y13:CLOCKREGION_X6Y14}
create_pblock pblock_hnf_2
add_cells_to_pblock [get_pblocks pblock_hnf_2] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/hnf_2]]
resize_pblock [get_pblocks pblock_hnf_2] -add {CLOCKREGION_X3Y15:CLOCKREGION_X6Y16}
create_pblock pblock_hnf_3
add_cells_to_pblock [get_pblocks pblock_hnf_3] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/hnf_3]]
resize_pblock [get_pblocks pblock_hnf_3] -add {CLOCKREGION_X3Y17:CLOCKREGION_X6Y18}

create_pblock pblock_rs_0x00
add_cells_to_pblock [get_pblocks pblock_rs_0x00] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/ccn_0_0x0 ln_simple_i/ln/inst/soc/uncore/noc/dev_reset_cc_0_rst_sync ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_ccn_0_id_0x0 ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_ccn_0_id_0x0_reset_resetSync]]
resize_pblock [get_pblocks pblock_rs_0x00] -add {CLOCKREGION_X4Y10:CLOCKREGION_X5Y10}
create_pblock pblock_rs_0x08
add_cells_to_pblock [get_pblocks pblock_rs_0x08] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_pip_id_0x8 ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_pip_id_0x8_reset_resetSync]]
resize_pblock [get_pblocks pblock_rs_0x08] -add {CLOCKREGION_X2Y10:CLOCKREGION_X2Y10}
create_pblock pblock_rs_0x10
add_cells_to_pblock [get_pblocks pblock_rs_0x10] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_0_id_0x10 ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_0_id_0x10_reset_resetSync]]
resize_pblock [get_pblocks pblock_rs_0x10] -add {CLOCKREGION_X2Y12:CLOCKREGION_X2Y12}
create_pblock pblock_rs_0x18
add_cells_to_pblock [get_pblocks pblock_rs_0x18] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_1_id_0x18 ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_1_id_0x18_reset_resetSync]]
resize_pblock [get_pblocks pblock_rs_0x18] -add {CLOCKREGION_X2Y14:CLOCKREGION_X2Y14}
create_pblock pblock_rs_0x20
add_cells_to_pblock [get_pblocks pblock_rs_0x20] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_2_id_0x20 ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_2_id_0x20_reset_resetSync]]
resize_pblock [get_pblocks pblock_rs_0x20] -add {CLOCKREGION_X2Y16:CLOCKREGION_X2Y16}
create_pblock pblock_rs_0x28
add_cells_to_pblock [get_pblocks pblock_rs_0x28] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_3_id_0x28 ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_3_id_0x28_reset_resetSync]]
resize_pblock [get_pblocks pblock_rs_0x28] -add {CLOCKREGION_X2Y18:CLOCKREGION_X2Y18}
create_pblock pblock_rs_0x78
add_cells_to_pblock [get_pblocks pblock_rs_0x78] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_0_id_0x78 ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_0_id_0x78_reset_resetSync]]
resize_pblock [get_pblocks pblock_rs_0x78] -add {CLOCKREGION_X7Y12:CLOCKREGION_X7Y12}
create_pblock pblock_rs_0x70
add_cells_to_pblock [get_pblocks pblock_rs_0x70] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_1_id_0x70 ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_1_id_0x70_reset_resetSync]]
resize_pblock [get_pblocks pblock_rs_0x70] -add {CLOCKREGION_X7Y14:CLOCKREGION_X7Y14}
create_pblock pblock_rs_0x68
add_cells_to_pblock [get_pblocks pblock_rs_0x68] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_2_id_0x68 ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_2_id_0x68_reset_resetSync]]
resize_pblock [get_pblocks pblock_rs_0x68] -add {CLOCKREGION_X7Y16:CLOCKREGION_X7Y16}
create_pblock pblock_rs_0x60
add_cells_to_pblock [get_pblocks pblock_rs_0x60] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_3_id_0x60 ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hnf_3_id_0x60_reset_resetSync]]
resize_pblock [get_pblocks pblock_rs_0x60] -add {CLOCKREGION_X7Y18:CLOCKREGION_X7Y18}
create_pblock pblock_rs_0x80
add_cells_to_pblock [get_pblocks pblock_rs_0x80] [get_cells -quiet [list ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_pip_id_0x80 ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_pip_id_0x80_reset_resetSync]]
resize_pblock [get_pblocks pblock_rs_0x80] -add {CLOCKREGION_X7Y10:CLOCKREGION_X7Y10}
create_pblock pblock_rs_dev
add_cells_to_pblock [get_pblocks pblock_rs_dev] [get_cells -quiet [list \
          ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hni_id_0x50 \
          ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_hni_id_0x50_reset_resetSync \
          ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_mn_id_0x40 \
          ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_mn_id_0x40_reset_resetSync \
          ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_pip_id_0x30 \
          ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_pip_id_0x30_reset_resetSync \
          ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_pip_id_0x58 \
          ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_pip_id_0x58_reset_resetSync \
          ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_rni_id_0x48 \
          ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_rni_id_0x48_reset_resetSync \
          ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_sn_id_0x38 \
          ln_simple_i/ln/inst/soc/uncore/noc/ring/ring_stop_sn_id_0x38_reset_resetSync]]
resize_pblock [get_pblocks pblock_rs_dev] -add {CLOCKREGION_X2Y19:CLOCKREGION_X7Y19}
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
