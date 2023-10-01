// Module for the FSM designed for detecting the pattern 10011001111
module FSM
    (
    // I/O ports of FSM
    input wire clk, reset,
    input wire state_input,
    output reg FSM_output
    );
    
    // States in FSM according to the diagram in report (defined according to the grey code)
    localparam S0 = 4'b0000,
               S1 = 4'b0001,
               S2 = 4'b0011,
               S3 = 4'b0010,
               S4 = 4'b0110,
               S5 = 4'b0111,
               S6 = 4'b0101,
               S7 = 4'b0100,
               S8 = 4'b1100,
               S9 = 4'b1101,
               S10 = 4'b1111;
               
      reg[3:0] state_reg, state_next;//For iterating through FSM        
      reg temp;//For the output of FSM  
      
      always @(posedge clk, posedge reset)
      begin
        if (reset)//go to state S0, if reset is high
        begin
            state_reg <= S0;
            FSM_output <= 0;
        end
        else //otherwise update the states
        begin
            state_reg <= state_next;
            FSM_output <= temp;
        end
      end
      
      //MOORE DESIGN - To iterate through the FSM
      always @(*)
      begin
        state_next = state_reg; // in case all other case statements fail
        temp = 0;
        case (state_reg)
            S0:
            begin
                if (state_input == 1'b1)
                    state_next <= S1;
                else
                    state_next <= S0;
            end
            S1:
            begin
                if (state_input == 1'b0)
                    state_next <= S2;
                else
                    state_next <= S1;
            end
            S2:
            begin
                if (state_input == 1'b0)
                    state_next <= S3;
                else
                    state_next <= S1;
            end
            S3:
            begin
                if (state_input == 1'b1)
                    state_next <= S4;
                else
                    state_next <= S0;
            end
            S4:
            begin
                if (state_input == 1'b1)
                    state_next <= S5;
                else
                    state_next <= S2;
            end
            S5:
            begin
                if (state_input == 1'b0)
                    state_next <= S6;
                else
                    state_next <= S1;
            end
            S6:
            begin
                if (state_input == 1'b0)
                    state_next <= S7;
                else
                    state_next <= S1;
            end
            S7:
            begin
                if (state_input == 1'b1)
                    state_next <= S8;
                else
                    state_next <= S0;
            end
            S8:
            begin
                if (state_input == 1'b1)
                    state_next <= S9;
                else
                    state_next <= S2;
            end
            S9:
            begin
                if (state_input == 1'b1)
                    state_next <= S10;
                else
                    state_next <= S6;
            end
            S10:
            begin
                if (state_input == 1'b0)
                    state_next <= S2;
                else
                begin
                    state_next <= S1;
                    temp <= 1'b1;  
                end
            end
        endcase
      end
                 
endmodule 