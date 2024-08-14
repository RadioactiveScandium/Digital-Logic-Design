`timescale 1ns/1ps
module glitch_less_mux_2to1_test ();

logic  sel;
logic  rstn;
logic  clk1;
logic  clk2;
logic  outclk;

glitchless_mux_2to1 glitchless_mux_2to1 (
                                                .*
                                        );

always #0.5 clk1 = ~clk1; 
always #1   clk2 = ~clk2; 

initial begin
   clk1 = 1'b0;
   clk2 = 1'b0;
   sel  = 1'b0;
end

initial begin
    $fsdbDumpvars("+fsdbfile+glitch_less_mux_2to1_test.fsdb","+all");
    rstn = 1'b0; #20;
    rstn = 1'b1; #100; 
    sel  = 1'b1; #104.8;
    sel  = 1'b0; #100;
    sel  = 1'b1; #100;
    //sel  = 1'b0; #100;
    //sel  = 1'b1; #100;
    $finish;
end

endmodule