module SLR (input clk,start,en,input [7:0] in, output reg [15:0] out=0);
reg [15:0] store;

always @(posedge clk )begin

if (en) begin
if (start)store<=in;
out<=store;
store<={store[14:0],1'b0};
end
end

endmodule
