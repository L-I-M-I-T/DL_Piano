`timescale 1ns / 1ps
module scale(piano,keycode,clk,key,speaker);
input piano;
input [31:0] keycode;
input clk;
input [7:0] key;
output speaker;
reg sound,fl;
integer count,t,p,f;

initial f=1;

always @(posedge clk) 
      if (keycode[7:0]==8'hf0) f<=0;
        else begin
           case (keycode[7:0]) 
              8'h16:t<=190839; 
              8'h1e:t<=180505; 
              8'h26:t<=170068; 
              8'h25:t<=160771; 
              8'h2e:t<=151515; 
              8'h36:t<=143266; 
              8'h3d:t<=135135; 
              8'h3e:t<=127551; 
              8'h46:t<=120481; 
              8'h45:t<=113636; 
              8'h4e:t<=107296;
              8'h55:t<=101214; 
              8'h15:t<=95602;
              8'h1d:t<=90252;
              8'h24:t<=85178;
              8'h2d:t<=80385;
              8'h2c:t<=75872;
              8'h35:t<=71633;
              8'h3c:t<=67567;
              8'h43:t<=63775;
              8'h44:t<=60168;
              8'h4d:t<=56818;
              8'h54:t<=54171;
              8'h5b:t<=50607;
              8'h1c:t<=47755;
              8'h1b:t<=45085;
              8'h23:t<=42553;
              8'h2b:t<=40160;
              8'h34:t<=37622;
              8'h33:t<=35790;
              8'h3b:t<=33783;
              8'h42:t<=31887;
              8'h4b:t<=30102;
              8'h4c:t<=28409;
              8'h52:t<=26809;
              8'h5a:t<=25303;
              8'h29:t<=0;
              8'h00:t<=0;
              default:;
            endcase
            if (f==0) begin t<=0;f<=1;end
          end
  
always @(posedge clk) 
  if (t>1) begin
    if (count>t) begin
        sound<=~sound;
        count<=0;
    end
    else count<=count+1;
  end
    
assign speaker=sound&piano;

endmodule