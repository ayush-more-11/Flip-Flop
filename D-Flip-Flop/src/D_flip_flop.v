`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2025 09:38:04
// Design Name: 
// Module Name: D_flip_flop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module D_flip_flop(input d, input clk, output reg q);

reg[26:0]counter = 0;
wire slow_clk;

assign slow_clk = ( counter == 24'd12_500_000);

always@(posedge clk) begin 
if( counter == 24'd12_500_000)
    counter <=0;
     
    else 
         counter <= counter + 1;
    end 
    
always@(posedge slow_clk)begin
    q <=d;
    end
endmodule
