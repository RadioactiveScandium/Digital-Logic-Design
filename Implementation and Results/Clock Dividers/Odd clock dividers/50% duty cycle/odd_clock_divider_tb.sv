`timescale 1ns/1ps
module clkdivbyn_odd_test ();

logic       rstn,clkin,clkout;
logic [3:0] divbyvalue;

clkdivbyn_odd dut ( 
                     .rstn(rstn),
                     .clkin(clkin),
                     .divbyvalue(divbyvalue),
                     .clkout(clkout)
                  );

always #0.5 clkin = ~clkin;

initial begin
    clkin = 1'b0;
    divbyvalue = 4'b0011; 
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,clkdivbyn_odd_test);
    #0.5 rstn = 1'b0; #20;
    rstn = 1'b1; #280;
    rstn = 1'b0; #120;   
    rstn = 1'b1; #80;
    $finish;
end
endmodule
