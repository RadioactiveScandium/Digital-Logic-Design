`timescale 1ns/1ps
module watchdog_timer_test #(parameter MAX_COUNT=32) ();

logic rstn;
logic clk;
logic data_in;
logic interrupt;

always #5 clk = ~clk;

watchdog_timer #(.MAX_COUNT(16))  
                dut(
                          .rstn(rstn),
                          .clk(clk),
                          .data_in(data_in),
                          .interrupt(interrupt)
                    );

initial begin
    rstn    = 1'b0;
    clk     = 1'b0;
    data_in = 1'b0; #20;
end

initial begin
    $fsdbDumpvars("+fsdbfile+watchdog_timer_test.fsdb","+all");
    #20;
    rstn = 1'b1;#50;
    data_in = 1'b1; #50;
    data_in = 1'b0; #120;
    #1000;
    data_in = 1'b1; #50;
    $finish;
end

endmodule