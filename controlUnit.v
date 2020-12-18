module controlUnit (input clk, start,zero, bLSB, output reg EB, EA, EP, Psel,output reg [1:0] state, output x,y,z);
parameter S0= 2'b00, S1= 2'b01,S2=2'b10; 
reg [1:0] currentState=S0, nextState =S0;
assign x= (currentState==S0);
assign y= (currentState==S1);
assign z= (currentState==S2);
always @(start or currentState) begin
state<=currentState;
case (currentState)
S0:begin
Psel<=1'b0;
EP<=1'b1;
EA<=1'b0;
EB<=1'b0;
if (start)
nextState<= S1;
else nextState<= S0;
end
S1: begin
Psel<=1'b1;
EP<=1'b1;
EA<=1'b1;
EB<=1'b1;
if (zero)
nextState<=S2;
else nextState <=S1;
if(bLSB)
EP<=1'b1;
else EP<=1'b0;
end
S2: begin
EP<=1'b0;
EA<=1'b0;
EB<=1'b0;
nextState<=S2;
end
default:nextState<=S0;
endcase
end
always @(posedge clk) begin
currentState <= nextState;
end
endmodule
