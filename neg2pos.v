module neg2pos(in,out); 

input [7:0] in;
output reg [7:0] out;

always @(*)
begin
if(in[7])
out = ~in + 1;
else
out = in;
end

endmodule
