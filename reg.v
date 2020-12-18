module reg16 (input clk, input [15:0] in,input enable, output reg [15:0] out=0);

always @ (posedge clk)
begin
if (enable)
begin
out<=in;
end
else out<=out;
end

endmodule
