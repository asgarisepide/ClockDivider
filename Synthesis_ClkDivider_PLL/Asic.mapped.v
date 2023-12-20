/////////////////////////////////////////////////////////////
// Created by: Synopsys Design Compiler(R) NXT Graphical
// Version   : U-2022.12
// Date      : Tue Dec 19 11:05:37 2023
// Netlist generated using set_compile_spg_mode ICC2 command enabled,
// which affects timing. Enable set_compile_spg_mode ICC2 in the flow.
/////////////////////////////////////////////////////////////


module vc_EnResetAsyncReg_2 ( clk, q, d, en, reset_BAR );
  output [0:0] q;
  input [0:0] d;
  input clk, en, reset_BAR;
  wire   n3, n4;

  SC8T_XOR2X0P5_CSC20R U3 ( .A(en), .B(q[0]), .Z(n4) );
  SC8T_TIELOX1_CSC20R DC_INCR_2 ( .Z(n3) );
  SC8T_SDFFRQX1_LP_CSC28R q_reg_0_ ( .D(n4), .SI(n3), .SE(n3), .CLK(clk), 
        .RESET(reset_BAR), .Q(q[0]) );
endmodule


module vc_EnResetAsyncReg_0 ( clk, q, d, en, reset_BAR );
  output [0:0] q;
  input [0:0] d;
  input clk, en, reset_BAR;
  wire   n1, n2;

  SC8T_XOR2X0P5_CSC20R U3 ( .A(en), .B(q[0]), .Z(n1) );
  SC8T_TIELOX1_CSC20R DC_INCR_2 ( .Z(n2) );
  SC8T_SDFFRQX0P5_CSC20R q_reg_0_ ( .D(n1), .SI(n2), .SE(n2), .CLK(clk), 
        .RESET(reset_BAR), .Q(q[0]) );
endmodule


module vc_Mux2 ( in0, in1, sel, out );
  input [0:0] in0;
  input [0:0] in1;
  output [0:0] out;
  input sel;


  SC8T_MUX2X1_A_CSC20R U1 ( .D0(in0[0]), .D1(in1[0]), .S(sel), .Z(out[0]) );
endmodule


module vc_EnResetAsyncReg_1 ( clk, q, d, en, reset_BAR );
  output [0:0] q;
  input [0:0] d;
  input clk, en, reset_BAR;
  wire   n1, n2;

  SC8T_XOR2X0P5_CSC20R U3 ( .A(en), .B(q[0]), .Z(n1) );
  SC8T_TIELOX1_CSC20R DC_INCR_2 ( .Z(n2) );
  SC8T_SDFFRQX1_LP_CSC28R q_reg_0_ ( .D(n1), .SI(n2), .SE(n2), .CLK(clk), 
        .RESET(reset_BAR), .Q(q[0]) );
endmodule


module Asic ( reset, clk, en_divN, divN, divM, clk_prescale_o, clk_gate_o );
  input [0:0] divN;
  input [2:0] divM;
  input reset, clk, en_divN;
  output clk_prescale_o, clk_gate_o;
  wire   div2q, div4q, div8q, phase_pass, N8, N9, N10, phase_gate, n10, n11,
         n13, n14, n15, n16, n17, n18, n19;
  wire   [2:0] counterM;

  vc_EnResetAsyncReg_2 div2 ( .clk(clk), .q(div2q), .d(n11), .en(en_divN), 
        .reset_BAR(n10) );
  vc_EnResetAsyncReg_1 div4 ( .clk(div2q), .q(div4q), .d(n11), .en(en_divN), 
        .reset_BAR(n10) );
  vc_EnResetAsyncReg_0 div8 ( .clk(div4q), .q(div8q), .d(n11), .en(en_divN), 
        .reset_BAR(n10) );
  vc_Mux2 muxN ( .in0(div4q), .in1(div8q), .sel(divN[0]), .out(clk_prescale_o)
         );
  SC8T_LATNQX1_CSC20R phase_gate_reg ( .CLK(clk_prescale_o), .D(phase_pass), 
        .Q(phase_gate) );
  SC8T_INVX1_CSC20R U22 ( .A(divM[1]), .Z(n14) );
  SC8T_INVX1_CSC20R U23 ( .A(counterM[0]), .Z(n18) );
  SC8T_ND2X0P5_CSC20R U24 ( .A(n18), .B(divM[0]), .Z(n13) );
  SC8T_FCGENIX0P5_CSC20R U25 ( .A(counterM[1]), .B(n14), .CI(n13), .CON(n15)
         );
  SC8T_FCGENIX0P5_CSC20R U27 ( .A(divM[2]), .B(n15), .CI(n16), .CON(n19) );
  SC8T_AOI221X0P5_A_CSC20R U35 ( .B1(counterM[0]), .B2(counterM[1]), .C1(n18), 
        .C2(n17), .A(n19), .Z(N9) );
  SC8T_OAI32X0P5_CSC20R U36 ( .B1(n19), .B2(n18), .B3(n17), .A1(n16), .A2(n19), 
        .Z(N10) );
  SC8T_TIELOX1_CSC20R DC_INCR_22 ( .Z(n11) );
  SC8T_SDFFRQX0P5_CSC20R counterM_reg_0_ ( .D(N8), .SI(n11), .SE(n11), .CLK(
        clk_prescale_o), .RESET(n10), .Q(counterM[0]) );
  SC8T_INVX2_F_CSC28R U26 ( .A(counterM[2]), .Z(n16) );
  SC8T_INVX2_F_CSC28R U34 ( .A(counterM[1]), .Z(n17) );
  SC8T_AN2X1_R2_CSC28R U32 ( .A(phase_gate), .B(clk_prescale_o), .Z(clk_gate_o) );
  SC8T_INVX2_F_CSC28R U37 ( .A(reset), .Z(n10) );
  SC8T_NR2X1_FB_CSC28R U33 ( .A(n19), .B(counterM[0]), .Z(N8) );
  SC8T2G_2BSDFFRQX1_CSC28R counterM_reg_2_1_ ( .D0(N10), .CLK(clk_prescale_o), 
        .RESET(n10), .SE(n11), .SI(n11), .Q0(counterM[2]), .D1(N9), .Q1(
        counterM[1]) );
  SC8T_SDFFRQX1_LP_CSC28R phase_pass_reg ( .D(n19), .SI(n11), .SE(n11), .CLK(
        clk_prescale_o), .RESET(n10), .Q(phase_pass) );
endmodule

