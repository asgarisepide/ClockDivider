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
