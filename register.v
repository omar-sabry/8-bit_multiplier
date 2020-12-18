module register(clk, rst, A_data, B_data, W_data, A_addr, B_addr, W_addr, wr);  

input clk;
input rst;
input wr;
output [7:0] A_data, B_data, W_data;
input [3:0] A_addr, B_addr, W_addr;

reg [7:0] RegFile[15:0];// 16 x 8-bit registers

//reading register
assign A_data = RegFile[A_addr];
assign B_data = RegFile[B_addr];

//writing to register
always @ (posedge clk) begin
if(!rst)
if(wr) RegFile[W_addr] <= W_data;
end

endmodule
