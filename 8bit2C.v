module RCA2C (input [7:0] in,output [7:0] out);

wire x0,x1,x2,x3,x4,x5,x6,x7;

assign x0= in[7]^in[0];
assign x1= in[7]^in[1];
assign x2= in[7]^in[2];
assign x3= in[7]^in[3];
assign x4= in[7]^in[4];
assign x5= in[7]^in[5];
assign x6= in[7]^in[6];
assign x7= in[7]^in[7]; 

assign out = (in[7])? ({x7,x6,x5,x4,x3,x2,x1,x0}+1) :({x7,x6,x5,x4,x3,x2,x1,x0});



endmodule
