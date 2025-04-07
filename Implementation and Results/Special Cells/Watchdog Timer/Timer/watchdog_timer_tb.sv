`timescale 1ns/1ps
module watchdog_timer_test #(parameter MAX_COUNT=32) ();

logic rstn;
logic clk;
logic flag;
logic interrupt;

always #0.5 clk = ~clk;

watchdog_timer #(.MAX_COUNT(100))  
                dut(
                          .rstn(rstn),
                          .clk(clk),
                          .flag(flag),
                          .interrupt(interrupt)
                    );

initial begin
    rstn    = 1'b0;
    clk     = 1'b0;
    flag = 1'b0; #20;
end

initial begin
    $fsdbDumpvars("+fsdbfile+watchdog_timer_test.fsdb","+all");
    #20;
    rstn = 1'b1;#50;
    flag = 1'b0; #50;
    flag = 1'b1; #206;
    flag = 1'b0; #50;
    $finish;
end

endmodule