`timescale 1ns/1ps
module signal_delayer_test();

logic       rstn,clk,sig_in,sig_out;
logic [3:0] delay_value;

signal_delayer signal_delayer_u1 ( 
   .* 
);

always #0.5 clk = ~clk;

initial begin
    rstn = 1'b0;
    clk  = 1'b0;
    sig_in = 1'b0;
    delay_value = 3'b000; 
end

initial begin
    $fsdbDumpvars("+fsdbfile+signal_delayer_test.fsdb","+all");
    #20;
    rstn = 1'b1; delay_value = 3'b001; sig_in = 1'b1;
    $display ("out is:%b",sig_out); #10;
    rstn = 1'b1; delay_value = 3'b001; sig_in = 1'b0;
    $display ("out is:%b",sig_out); #10;
    rstn = 1'b1; delay_value = 3'b111; sig_in = 1'b1;
    $display ("out is:%b",sig_out); #10;
    rstn = 1'b1; delay_value = 3'b110; sig_in = 1'b0;
    $display ("out is:%b",sig_out); #10;
    rstn = 1'b1; delay_value = 3'b110; sig_in = 1'b1;
    $display ("out is:%b",sig_out); #10;
    rstn = 1'b1; delay_value = 3'b110; sig_in = 1'b0;
    $display ("out is:%b",sig_out); #10;
    #280;
    rstn = 1'b0;
    $finish;
end
endmodule 
