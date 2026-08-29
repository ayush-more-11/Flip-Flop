`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2025 10:26:43
// Design Name: 
// Module Name: T_flip_flop
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


module T_flip_flop(clk, T, reset, Q);

input clk;
input T;
input reset;
output reg Q;

reg[26:0]counter = 0;
wire slow_clk;

assign slow_clk = ( counter == 24'd12_500_000);

always@(posedge clk) begin 
if( counter == 24'd12_500_000)
    counter <=0;
    
    else 
         counter <= counter + 1;
    end 
    
always@(posedge slow_clk or posedge reset ) begin
if(reset) begin
    Q <= 0;
    end 
    else 
    if (T) begin 
        Q <= ~Q;
    end
end
endmodule




