module zeroCheck(input [7:0] in,input [1:0] temp, output reg out=1'b0);

always @(*) begin
if (temp==2'b01)begin

out<=~(in[0]|in[1]|in[2]|in[3]|in[4]|in[5]|in[6]|in[7]);
end
end
endmodule
