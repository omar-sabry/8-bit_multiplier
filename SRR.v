module SRR (input clk,start,en , input [7:0] in, output reg [7:0] out=0);
reg [15:0] store;

always @(posedge clk )begin
if (en) begin
if (start)store=in;
out<=store;
store<={1'b0,store[7:1]};
end
end

endmodule
