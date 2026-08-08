# 时钟信号 (100MHz)
set_property PACKAGE_PIN P17 [get_ports clk_100MHz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100MHz]
set_property PACKAGE_PIN P15 [get_ports reset_rtl_0]
set_property IOSTANDARD LVCMOS33 [get_ports reset_rtl_0]
# 开关 SW0
set_property PACKAGE_PIN N4 [get_ports sw0_0]
set_property IOSTANDARD LVCMOS33 [get_ports sw0_0]

# 数码管片选 (AN)
set_property PACKAGE_PIN H1 [get_ports {an_0[0]}]  ;# DN0_K4 
set_property IOSTANDARD LVCMOS33 [get_ports {an_0[0]}]
set_property PACKAGE_PIN C1 [get_ports {an_0[1]}]  ;# DN0_K3
set_property IOSTANDARD LVCMOS33 [get_ports {an_0[1]}]
set_property PACKAGE_PIN C2 [get_ports {an_0[2]}]  ;# DN0_K2
set_property IOSTANDARD LVCMOS33 [get_ports {an_0[2]}]
set_property PACKAGE_PIN G2 [get_ports {an_0[3]}]  ;# DN0_K1
set_property IOSTANDARD LVCMOS33 [get_ports {an_0[3]}]

# ==========================================
# 数码管段选 (SEG) - 对应 LED0 组
# 编码顺序: seg[7:0] = {DP, G, F, E, D, C, B, A}
# ==========================================
set_property PACKAGE_PIN D5 [get_ports {seg_0[7]}] ;# DP0
set_property IOSTANDARD LVCMOS33 [get_ports {seg_0[7]}]
set_property PACKAGE_PIN B2 [get_ports {seg_0[6]}] ;# G0
set_property IOSTANDARD LVCMOS33 [get_ports {seg_0[6]}]
set_property PACKAGE_PIN B3 [get_ports {seg_0[5]}] ;# F0
set_property IOSTANDARD LVCMOS33 [get_ports {seg_0[5]}]
set_property PACKAGE_PIN A1 [get_ports {seg_0[4]}] ;# E0
set_property IOSTANDARD LVCMOS33 [get_ports {seg_0[4]}]
set_property PACKAGE_PIN B1 [get_ports {seg_0[3]}] ;# D0
set_property IOSTANDARD LVCMOS33 [get_ports {seg_0[3]}]
set_property PACKAGE_PIN A3 [get_ports {seg_0[2]}] ;# C0
set_property IOSTANDARD LVCMOS33 [get_ports {seg_0[2]}]
set_property PACKAGE_PIN A4 [get_ports {seg_0[1]}] ;# B0
set_property IOSTANDARD LVCMOS33 [get_ports {seg_0[1]}]
set_property PACKAGE_PIN B4 [get_ports {seg_0[0]}] ;# A0
set_property IOSTANDARD LVCMOS33 [get_ports {seg_0[0]}]


set_property PACKAGE_PIN C12 [get_ports vauxp1]
         
