module asy_fifio_tb();
reg w_clk,r_clk,w_en,r_en,reset;
wire[4:0] w_bp,r_bp;
reg[7:0]data_in;
wire[7:0] d_out;
asy_fifo dut(.w_clk(w_clk),.w_bp(w_bp),.r_bp(r_bp),.r_clk(r_clk),.w_en(w_en),.r_en(r_en),.reset(reset),.data_in(data_in),.d_out(d_out),.full(full),.empty(empty));
initial begin
w_clk=1'b0;
r_clk=1'b0;
data_in=8'b0;
w_en=1'b0;
r_en=1'b0;
reset=1'b0;
end
always
#50 w_clk<=~w_clk;
always
#30 r_clk<=~r_clk;
initial begin
$monitor("time=%0t  RESET=%b  w_en=%b  r_en =%b   DATA_in =%d  d_out=%d  FULL =%b  EMPTY= %b  wp= %d  rp=%d",$time,reset,w_en,r_en,data_in,d_out,full,empty,w_bp,r_bp);
end
initial begin
//basic write 3 data values
#60;
repeat(3)begin 
data_in=data_in+1;
#100;
end#160;
repeat (18)begin
data_in=data_in+1'b1;
#100;
end
end
initial begin
#20 reset=1;
// basic read write operation
#40 w_en=1;
#240 r_en=1;
#60 w_en=1'b0;
#60 r_en=1'b0;
 
 // reset before full test
 #70 reset=0;
 #10 reset=1;
 
 //full test
 #20 w_en=1;
 #1720 w_en=0;
//empty test
 #80 r_en=1;
 #1040 r_en=0;
 #100 $finish;
 end
endmodule
