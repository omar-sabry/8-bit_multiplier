module pro_7_seg (input [3:0]in, output reg [6:0] out);
always @(in)begin
case(in)
0 : out = 7'b0000001;
1 : out = 7'b1001111;
2 : out = 7'b0010010;
3 : out = 7'b0000110;
4 : out = 7'b1001100;
5 : out = 7'b0100100;
6 : out = 7'b0100000;
7 : out = 7'b0001111;
8 : out = 7'b0000000;
9 : out = 7'b0000100;
10 : out = 7'b0001000;
11 : out = 7'b1100000;
12 : out = 7'b0110000;
13 : out = 7'b1000010;
14 : out = 7'b0110000;
15 : out = 7'b0111000;
endcase
end
endmodule

module decoder2x4 (in, out);
output reg [3:0]out;
input [1:0] in;
always@(in)begin
if (in==2'b00)
 out=4'b1110;
else if (in==2'b01)
out=4'b1101;
else if(in==2'b10) 
out=4'b1011;
else
out=4'b0111;
end
endmodule

module N_counter (input clk, output reg [1:0]count);
always @(posedge clk) 
 begin
count <= count + 1;
end
endmodule

module muxDisplay ( input [6:0] a, b, c, d, input [1:0] sel,output [6:0] out);
   assign out = sel[1]? (sel[0] ? d : c) : (sel[0] ? b : a);
endmodule

module clockDivider (input clk, input rst, output reg clk_div);
localparam constantNumber = 500000;
reg [31:0] count;
always @ (posedge(clk), posedge(rst))
begin
    if (rst == 1'b1)
        count <= 32'b0;
    else if (count == constantNumber - 1)
        count <= 32'b0;
    else
        count <= count + 1;
end
always @ (posedge(clk), posedge(rst))
begin
    if (rst == 1'b1)
        clk_div <= 1'b0;
    else if (count == constantNumber - 1)
        clk_div <= ~clk_div;
    else
        clk_div <= clk_div;
end
endmodule

module bin2bcd
 #( parameter                W = 16)  // input width
  ( input      [W-1      :0] bin   ,  // binary
    output reg [W+(W-4)/3:0] bcd   ); // bcd {...,thousands,hundreds,tens,ones}

  integer i,j;

  always @(bin) begin
    for(i = 0; i <= W+(W-4)/3; i = i+1) bcd[i] = 0;     // initialize with zeros
    bcd[W-1:0] = bin;                                   // initialize with input vector
    for(i = 0; i <= W-4; i = i+1)                       // iterate on structure depth
      for(j = 0; j <= i/3; j = j+1)                     // iterate on structure width
        if (bcd[W-i+4*j -: 4] > 4)                      // if > 4
          bcd[W-i+4*j -: 4] = bcd[W-i+4*j -: 4] + 4'd3; // add 3
  end
endmodule

module display(input clk,input [15:0] in, output [6:0]out, output [3:0]enables, tensdisp);
wire hz100;
wire [1:0] counter;
wire [3:0]  hundreds, tens, ones;
wire [6:0] out1, out2, out3, out4;
clockDivider cd1 ( clk,0, hz100);
N_counter n1 (hz100, counter);
decoder2x4 d1 (counter, enables);
assign tensdisp=tens;
wire [19:0] bcdDivider;
wire [4:0]thousands;
bin2bcd(in, bcdDivider);
assign thousands=bcdDivider[15:12];
assign hundreds=bcdDivider[11:8];
assign tens = bcdDivider[7:4];
assign ones= bcdDivider [3:0];
pro_7_seg p7s1 (thousands, out4);
pro_7_seg p7s2 (hundreds, out2);
pro_7_seg p7s3 (tens, out3);
pro_7_seg p7s4 (ones, out1);
muxDisplay m1 (out1, out2, out3, out4, counter,out);
endmodule
