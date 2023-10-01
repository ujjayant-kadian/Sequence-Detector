//Module containing all the other modules
module Top
    (
    //I/O ports for Top
    input wire CCLK, reset,
    input wire change_bits, //to change the bits being shown on the board
    output reg[10:0] temp,//to switch between the bits as we have a tap length of 21 bits   
    output wire max_tick_reg,
    output wire[3:0] an,
    output wire[7:0] sseg
    );
    wire clk;
    wire[20:0] lfsr_reg; // to store the actual LFSR output
    wire FSM_output;
    wire[3:0] d3, d2, d1, d0;
    
    //Instantiation of clock
    clock clk_signal (.CCLK(CCLK), .clkscale(50000000), .clk(clk));
    //Intantiation of LFSR
    LFSR_21bit init (.clk(clk), .reset(reset), .Q_out(lfsr_reg), .max_tick_reg(max_tick_reg));
    //Instantiation of FSM
    FSM detect_pattern(.clk(clk), .reset(reset), .state_input(lfsr_reg[20]), .FSM_output(FSM_output));
    //Instantiation of counter
    counter num_of_times (.clk(clk), .reset(reset), .max_tick_reg(max_tick_reg), .FSM_output(FSM_output), .d3(d3), .d2(d2), .d1(d1), .d0(d0));
    //Instantiation of disp_hex_mux
    disp_hex_mux disp_unit (.clk(clk), .reset(1'b0), .hex3(d3), .hex2(d2), .hex1(d1), .hex0(d0), .dp_in(4'b1111), .an(an), .sseg(sseg));
    
    //Switching the bits that are represented on LED
    
    always @(*)
    begin
        if (change_bits == 1'b1)
            temp = lfsr_reg[10:0];
        else
            temp = {1'b0, lfsr_reg[20:11]};
    end
        
    assign an = an | 4'b0000;//To enable all 4 digits of 7 segment diplay            
endmodule