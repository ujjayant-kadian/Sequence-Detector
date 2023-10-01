// Basys Board and Spartan -3E Starter Board...
module clock (input CCLK, input [31: 0] clkscale, output reg clk) ;
                                            // CCLK crystal clock oscillator 100 Mhz
reg [31:0] clkq=0;                          // clock register, initial value of 0
always@ (posedge CCLK)  
begin
    clkq=clkq+1;                // Increment clock register
        if (clkq>=clkscale)        // clock scaling 
        //only change clock value if it is >= the scaling parameter
            begin  
                clk=~clk; //output clock
                clkq=0 ;  // reset clock register
            end
        end
endmodule