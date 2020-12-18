module shift(clk, rst, sinl, sinr, ctrl, in, out);
input clk;
input rst;
input sinl,sinr; //serial input for shift left and shift right
input [1:0] ctrl; // 10:shift left, 01:shift right, 11:load
input [7:0] in;
output reg [7:0] out;


always @ (posedge clk) begin
if (!rst) out<=8'b00000000; //synchronus reset active low
else begin
case(ctrl)
2'b10: out <= {out[6:0],sinl}; //left shift
2'b01: out <= {sinr, out[7:1]}; //right shift
2'b11: out <= in; //load
endcase
end
end

endmodule
