`timescale 1ns/1ps
module clkdiv_even_test ();

logic rstn,clkin,clkout;
logic [2:0] divbyvalue;

clkdiv_even dut ( 
                     .rstn(rstn),
                     .clkin(clkin),
                     .divbyvalue(divbyvalue),
                     .clkout(clkout)
              );

always #0.5 clkin = ~clkin;

initial begin
    clkin = 1'b0;
    //divbyvalue = 3'b000; --> by 2
    //divbyvalue = 3'b001; --> by 4
    //divbyvalue = 3'b010; --> by 6
    //divbyvalue = 3'b011; --> by 8
    //divbyvalue = 3'b100; --> by 10
    //divbyvalue = 3'b111; 
    divbyvalue = 3'b000; 
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,clkdiv_even_test);
    //$fsdbDumpvars("+fsdbfile+clkdivbyn_test.fsdb","+all");
    rstn = 1'b0; #20;
    rstn = 1'b1; #280;
    rstn = 1'b0; #120;   
    rstn = 1'b1; divbyvalue = 3'b001; #80;
    $finish;
end
endmodule
