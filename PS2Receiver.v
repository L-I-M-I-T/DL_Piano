`timescale 1ns / 1ps
module controller(read,clk,kclk,kdata,rst,keycodeout,led,queue,f);
input read;
input clk;
input kclk;
input kdata;
input rst;
output [31:0] keycodeout;
output [7:0] led;
output [31:0] queue;
output f;
reg [31:0] c;
wire kclkf, kdataf;
reg [7:0] datacur;
reg [7:0] dataprev;
reg [3:0] cnt=0;
reg [31:0] keycode=0;
reg flag=0,flag_old=0,fl;
reg [31:0] queue2=0;
integer con;

debouncer debounce(.clk(clk),.I0(kclk),.I1(kdata),.O0(kclkf),.O1(kdataf));

initial begin
  fl=f;
  con=0;
end

always@(negedge kclkf) begin
  case(cnt)
    0:;
    1:datacur[0]<=kdataf;
    2:datacur[1]<=kdataf;
    3:datacur[2]<=kdataf;
    4:datacur[3]<=kdataf;
    5:datacur[4]<=kdataf;
    6:datacur[5]<=kdataf;
    7:datacur[6]<=kdataf;
    8:datacur[7]<=kdataf;
    9:flag<=1'b1;
    10:flag<=1'b0;
  endcase
  if(cnt<=9) cnt<=cnt+1; else cnt<=0;
end

always @(posedge clk ) begin
  flag_old<=flag; 
  if (rst==1) begin keycode<=0;con<=0;end
    else begin
      if ((flag_old==0)&&(flag==1)&&(read==1)) begin
         if ((con==0)&&(datacur==8'h71)) con=3;
         if (con==0) begin
           keycode[31:24]<=keycode[23:16];
           keycode[23:16]<=keycode[15:8];
           keycode[15:8]<=dataprev;
           keycode[7:0]<=datacur;
           dataprev<=datacur;
         end
         else con=con-1;
      end
    end
end

assign keycodeout=keycode;
assign led=keycode[7:0];
assign queue=queue2;
assign f=fl;

endmodule
