`timescale 1ns / 1ps
module top(CLK,ps2_clk,ps2_data,rst,SEG,AN,DP,LED,speaker);
input CLK;
inout ps2_clk;
inout ps2_data;
input rst;
output [6:0] SEG;
output [7:0] AN;
output DP;
output [7:0] LED;
output speaker;  
wire [31:0] keycode;
wire [31:0] queue;
wire [31:0] con;
integer i;
wire f;

assign read=1;
assign piano=1;
assign display=1;

controller controller(
.read(read),
.clk(CLK),
.kclk(ps2_clk),
.kdata(ps2_data),
.rst(rst),
.keycodeout(keycode[31:0]),
.led(LED),
.queue(queue[15:0]),
.f(f)
);

scale scaler(
.piano(piano),
.keycode(keycode),
.clk(CLK),
.key(LED),
.speaker(speaker)
);

seg7decimal sevenSeg(
.display(display),
.x(keycode[31:0]),
.clk(CLK),
.seg(SEG[6:0]),
.an(AN[7:0]),
.dp(DP)
);

endmodule