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

