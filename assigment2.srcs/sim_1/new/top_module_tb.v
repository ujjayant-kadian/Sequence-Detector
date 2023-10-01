`timescale 1ns / 1ps

module top_tb();
    reg clk;
    reg reset;
    wire max_tick_reg;
    wire[20:0] Q_out;
    wire[3:0] d3, d2, d1, d0;
    wire FSM_output;
    
    LFSR_21bit uut (.clk(clk), .reset(reset), .max_tick_reg(max_tick_reg), .Q_out(Q_out));
    FSM uut_fsm (.clk(clk), .reset(reset), .state_input(Q_out[20]), .FSM_output(FSM_output));
    counter uut_counter (.clk(clk), .reset(reset), .max_tick_reg(max_tick_reg), .FSM_output(FSM_output), .d3(d3), .d2(d2), .d1(d1), .d0(d0));
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