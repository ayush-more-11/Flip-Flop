`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2025 10:11:04
// Design Name: 
// Module Name: D_flip_flop_tb
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


module D_flip_flop_tb;


    // Inputs to the D flip-flop
    reg d;
    reg clk;

    // Output of the D flip-flop
    wire q;

    // Instantiate the D flip-flop
    D_flip_flop uut (
        .d(d),
        .clk(clk),
        .q(q)
    );

    // Clock generation (50 MHz)
    always begin
        clk = 0;
        #10 clk = 1;   // 50 MHz clock (20ns period)
        #10 clk = 0;
    end

    // Stimulus to the `d` input
    initial begin
        // Initial values
        d = 0;
        clk = 0;

        // Apply test stimulus
        #15 d = 1;     // Set `d` high at 15ns
        #25 d = 0;     // Set `d` low at 40ns
        #50 d = 1;     // Set `d` high at 90ns
        #100 d = 0;    // Set `d` low at 190ns
        #200 d = 1;    // Set `d` high at 390ns
        #300 d = 0;    // Set `d` low at 690ns
        #400 d = 1;    // Set `d` high at 1090ns

        // End simulation after a while
        #1000;
        $finish;
    end

    // Monitor the signals
    initial begin
        $monitor("Time = %0t, clk = %b, d = %b, q = %b", $time, clk, d, q);
    end

endmodule