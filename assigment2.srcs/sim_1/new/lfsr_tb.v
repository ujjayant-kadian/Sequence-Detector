`timescale 1ns / 1ps

module LFSR_tb();
    reg clk;
    reg reset;
    wire max_tick_reg;
    wire Q_out;
    
    LFSR_21bit uut (.clk(clk), .reset(reset), .max_tick_reg(max_tick_reg), .Q_out(Q_out));
    
    // Oscillate clock with 20 ns period
    always
    begin
        clk = 1'b1; //high
        #10;
        clk = 1'b0; //low
        #10;
    end
    
    // Reset signal
    initial
    begin
        reset = 1'b1;
        #200; // Reset high for first 10 clock cycles
        reset = 1'b0;
    end
endmodule