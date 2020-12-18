module mux2(y,sel,out);
  input [15:0]  y;
  input sel;
  output [15:0] out;

assign out = (sel)? y:16'b0;

endmodule
