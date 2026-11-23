module asy_fifo(input w_clk,r_clk,w_en,r_en,reset,input[7:0]data_in,output reg [7:0]d_out,output reg full=0,empty=1,
output reg[4:0]r_bp,w_bp);
reg[4:0]r_gp,w_gp,ffw1,ffw2,ffr1,ffr2,ch;
reg[7:0]mem[15:0];
always@(posedge w_clk,negedge reset)begin
if(!reset)begin
w_bp<=5'b0;
w_gp<=5'b0;
full<=1'b0;
ch<=5'b11000;
ffw1<=0;
ffw2<=0;
end
else begin
ffw1<=r_gp;
ffw2<=ffw1;
ch={~ffw2[4:3],ffw2[2:0]};
full<=(ch==w_gp);
if(full|~w_en)
w_bp<=w_bp;
else begin
mem[w_bp[3:0]]<=data_in;
w_bp<=w_bp+5'b1;
w_gp<=(w_bp+5'b1)^((w_bp+5'b1)>>1);
end
end
end
always@(posedge r_clk,negedge reset)begin
if(!reset)begin
r_bp<=5'b0;
r_gp<=5'b0;
empty<=1'b1;
d_out<=8'b0;
ffr1<=8'b0;
ffr2<=8'b0;
end
else begin
ffr1<=w_gp;
ffr2<=ffr1;
empty<=(ffr2==r_gp);
if(empty|~r_en)begin
r_bp<=r_bp;
d_out<=8'b0;
end
else begin
d_out<=mem[r_bp[3:0]];
r_bp<=r_bp+5'b1;
r_gp<=(r_bp+5'b1)^((r_bp+5'b1)>>1);
end
end
end
endmodule
