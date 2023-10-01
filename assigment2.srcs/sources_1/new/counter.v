//Module to count the number of times the pattern/sequence occurs
//Inspired by stop_watch_if.v from LAB G
module counter
    (
    //I/O ports for counter
    input wire clk, reset, FSM_output, max_tick_reg,
    output wire [3:0] d3, d2, d1, d0
    );
    
    //declaration
    reg [3:0] d3_reg, d2_reg, d1_reg, d0_reg;
    reg [3:0] d3_next, d2_next, d1_next, d0_next;
    
    //body
    always @(posedge clk)
    begin
       d3_reg <= d3_next;
       d2_reg <= d2_next;
       d1_reg <= d1_next;
       d0_reg <= d0_next;
    end
    
   always @(*)
   begin
   //Default: Keep the previous value
    d0_next = d0_reg;
    d1_next = d1_reg;
    d2_next = d2_reg;
    d3_next = d3_reg;   
    if (max_tick_reg)
    begin
        d0_next = 4'b0;
        d1_next = 4'b0;
        d2_next = 4'b0;
        d3_next = 4'b0;
    end
    else if (FSM_output)
        if (d0_reg != 9)
            d0_next = d0_reg + 1;
        else
        begin
            d0_next = 4'b0;
            if (d1_reg != 9)
            d1_next = d1_reg + 1;
            else
            begin
                d1_next = 4'b0;
                if (d2_reg != 9)
                    d2_next = d2_reg + 1;
                else
                begin
                    d2_next = 4'b0;
                    if(d3_reg != 9)
                        d3_next = d3_reg + 1;
                    else
                        d3_next = 4'b0;
                end
            end
        end
   end
 
    // output logic
    assign d0 = d0_reg;
    assign d1 = d1_reg;
    assign d2 = d2_reg;
    assign d3 = d3_reg;
    
endmodule
