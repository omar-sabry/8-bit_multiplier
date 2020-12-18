module mux2(x,y,sel,out);
  input [15:0] x, y;
  input sel;
  output reg [15:0] out;

  always@(x,y,sel)begin
    if(sel==0)
      out=x;
    else
      out=y;
  end
endmodule
