`timescale 1ps/1ps
`include "Asic.v"

module Asic_tb;
  localparam p_divN_bits = 1;
  localparam p_divM_bits = 3;

  reg reset, clk, en_divN;
  reg [p_divN_bits-1:0] divN;
  reg [p_divM_bits-1:0] divM;

  wire clk_prescale_o, clk_gate_o;

  Asic #(
    .p_divN_bits(p_divN_bits),
    .p_divM_bits(p_divM_bits)
  ) DUT (
    .reset(reset),
    .clk(clk),
    .en_divN(en_divN),
    .divN(divN),
    .divM(divM),
    .clk_prescale_o(clk_prescale_o),
    .clk_gate_o(clk_gate_o)
  );

always begin
 #5 clk = ~clk;
end

  initial begin 
    $dumpfile("Asic.vcd");
    $dumpvars;   
    
    reset = 1;
    clk = 0;
    en_divN = 0;
    divN = 0;
    divM = 0;

    #10 reset = 0;
    #10 en_divN=1;
  end

  initial begin
    #50  divN = 1;
    #300 divN = 0;
    #50  divM = 4;

    #400 $finish;
  end

endmodule
