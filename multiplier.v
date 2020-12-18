module multiplier (input clk,A, output [6:0] disp, output [3:0] enables,check,output sign, x, y,z,u);

wire start, start0;
wire [7:0] Md=8'b00001010;
wire [7:0] Mr=8'b00000001;
wire [7:0] Md2C, Mr2C;
wire EA, Psel, zero;
wire [15:0] Mdsl, rca16b, product,Mrsr;
wire [1:0] currentState;
assign u =start0;
UART_receiver u1 (clk,A,RxData,start0);
pos_edge_det ped1 (start0,clk,start);


 RCA2C rca1 (Md,Md2C);

 SLR slr1 (clk,start,EA,Md2C,Mdsl);
assign rca16b = Mdsl + product;

wire EP, EB;
wire [15:0] outmux;

 mux2 m11 (rca16b,Psel,outmux);
 reg16 reg1 (clk, outmux,EP,product); 
 assign sign= Md[7]^Mr[7];
 
 display disp1(clk,product,disp,enables, check);
  RCA2C rca2 (Mr,Mr2C);
SRR srr1 (clk,start,EB ,Mr2C,Mrsr);
 
 zeroCheck zc1 (Mrsr,currentState,zero);
 
 controlUnit cu1 (clk, start,zero, Mrsr[0], EB, EA, EP, Psel,currentState,x ,y, z);
endmodule
