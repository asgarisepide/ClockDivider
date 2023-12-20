module vc_Mux2
#(
  parameter p_nbits = 1
)(
  input      [p_nbits-1:0] in0, in1,
  input                    sel,
  output reg [p_nbits-1:0] out
);

  always @(*)
  begin
    case ( sel )
      1'd0 : out = in0;
      1'd1 : out = in1;
      default : out = {p_nbits{1'bx}};
    endcase
  end

endmodule


module vc_EnResetAsyncReg
#(
  parameter p_nbits       = 1,
  parameter p_reset_value = 0
)(
  input  logic               clk,   // Clock input
  input  logic               reset, // Sync reset input
  output logic [p_nbits-1:0] q,     // Data output
  input  logic [p_nbits-1:0] d,     // Data input
  input  logic               en     // Enable input
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
         q <= p_reset_value;
    end else if (en) begin
        q <= d;
      end
   end

endmodule


module Asic 
#(
  parameter p_divN_bits = 1,
  parameter p_divM_bits = 3
)(
  input  logic reset,
  input  logic clk,
  input  logic en_divN,

  input  logic [p_divN_bits-1:0] divN, // 0 for ÷4 and 1 for ÷8
  input  logic [p_divM_bits-1:0] divM, // 0 for ÷1, 1 for ÷2, \u2026, 7 for ÷8

  output logic clk_prescale_o,
  output logic clk_gate_o
);
  // divide-by-N (N = 4 or 8)
  logic div2q, div2d; 
  logic div4q, div4d;
  logic div8q, div8d;
  // logic en_divN;
  logic clkN; // 0 for ÷1, 1 for ÷2, \u2026, 7 for ÷8

  logic phase_pass;
  logic [p_divM_bits-1:0] counterM; // M
  logic clkM;

  // gating logic
  logic phase_gate;
  assign div2d   = ~div2q; // flop output fed back to flop input
  vc_EnResetAsyncReg div2 ( .clk(clk),.reset(reset),.q(div2q),.d(div2d),.en(en_divN) ); 
  assign div4d   = ~div4q;
  vc_EnResetAsyncReg div4 ( .clk(div2q),.reset(reset),.q(div4q),.d(div4d),.en(en_divN) ); 
  assign div8d   = ~div8q;
  vc_EnResetAsyncReg div8 ( .clk(div4q),.reset(reset),.q(div8q),.d(div8d),.en(en_divN) );

  vc_Mux2 muxN ( .in0(div4q),.in1(div8q),.sel(divN),.out(clkN) );

  always @(posedge clkN or posedge reset) begin
        if (reset) begin
            counterM   <= 0;    // like this for counterM, but rather just
            phase_pass <= 0;    // a reset in a posedge always block then
  	end else if (counterM >= divM) begin
  		counterM   <= 0;
  	        phase_pass <= 1;
  	    end else begin
  		counterM   <= counterM + 1;
  		phase_pass <= 0;
            end  	
  end

  always @(*)
    if (~clkN)
       phase_gate <= phase_pass;
       assign clkM = clkN & phase_gate;  

       assign clk_prescale_o = clkN;
       assign clk_gate_o     = clkM;

endmodule
