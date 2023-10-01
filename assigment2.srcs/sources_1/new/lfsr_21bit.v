// MODULE FOR Linear Feedback Shift Register (LFSR)
module LFSR_21bit
    (
    //I/O ports for LFSR
    input wire clk, reset,
    output wire[20:0] Q_out,
    output reg max_tick_reg //Goes high for a single clock cycle when full count of LFSR is reached
    );
    
    localparam seed = 21'b101001011111000001100;//LFSR_SEED given for this assignment
    
    reg [20:0] Q_state;//to store intermediatory states values
    reg [20:0] Q_ns;//for the next state of LFSR
    reg feedback;//to store the feedback generated
    
    integer cycle;//to store the count of cycles
    
    always @(posedge clk, posedge reset) // Triggered on the positve edge of clk with async. active high reset
    begin
        if (reset)
        begin
            //Initialising first state with the seed value generated
            Q_state <= seed;
            //Resetting max_tick_reg
            max_tick_reg <= 1'b0;
            //Initialising the number of cycle counts to 0
            cycle <= 0;
        end
        else
        begin
            Q_state <= Q_ns;//Setting Q_state register value to next LFSR generated register value
            cycle <= cycle + 1; //Incriment the cycle by 1
            if (cycle == 2**21 - 1) // When reached the maximum length of LFSR (2^N - 1, here N = 21)
            begin 
                max_tick_reg <= 1'b1; //Assign max_tick_reg with 1 to indicate one full cycle has occurred
            end    
        end          
    end
    //This always block is for next state logic - not dependent on clk or reset
    always @(*)
    begin
        feedback = (Q_state[20] ^ Q_state[18]);//XNOR LOGIC. Feedback generated according to the table, for 21 tap length we have to take xor of Q21(or Q_state[20]) and Q19(or Q_state[18]) 
        Q_ns = {Q_state[20:0], feedback}; //concatenating the 21-0 bits of Q_state with feedback
    end 
    //Output logic
    assign Q_out = Q_state;
endmodule
