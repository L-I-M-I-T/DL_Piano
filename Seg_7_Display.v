`timescale 1ns / 1ps
module seg7decimal(display,x,clk,seg,an,dp);
input display;
input [31:0] x;
input clk;
output reg [6:0] seg;
output reg [7:0] an;
output wire dp;
wire [2:0] s;	 
reg [3:0] digit;
wire [7:0] aen;
reg [19:0] clkdiv;

assign dp = 1;
assign s = clkdiv[19:17];
assign aen = 8'b11111111;

always @(posedge clk)
    if (display)
	  case(s)
	     0:digit = x[3:0]; 
	     1:digit = x[7:4]; 
	     2:digit = x[11:8];
	     3:digit = x[15:12]; 
	     4:digit = x[19:16];
         5:digit = x[23:20];
         6:digit = x[27:24]; 
         7:digit = x[31:28]; 
	     default:digit = x[3:0];
	  endcase
always @(*)
    if (display)
      case(digit)
          0:seg = 7'b1000000;			
          1:seg = 7'b1111001;
          2:seg = 7'b0100100;							
          3:seg = 7'b0110000;							 	
          4:seg = 7'b0011001;						    
          5:seg = 7'b0010010;                                    
          6:seg = 7'b0000010;
          7:seg = 7'b1111000;
          8:seg = 7'b0000000;
          9:seg = 7'b0010000;
          'hA:seg = 7'b0001000; 
          'hB:seg = 7'b0000011; 
          'hC:seg = 7'b1000110;
          'hD:seg = 7'b0100001;
          'hE:seg = 7'b0000110;
          'hF:seg = 7'b0001110;
          default: seg = 7'b0000000;
      endcase

always @(*) 
    if (display) begin 
      an=8'b11111111;
      if (aen[s] == 1) an[s] = 0;
    end

always @(posedge clk) clkdiv <= clkdiv+1;

endmodule
