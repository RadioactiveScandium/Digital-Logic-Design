`timescale 1ns/1ps
module watchdog_timer_driver_test #(parameter DATA_WIDTH = 32)();

logic                  clk;
logic                  rstn;
logic [DATA_WIDTH-1:0] data_in;
logic                  delta;

watchdog_timer_driver driver_dut(
                                      .clk(clk),
                                      .rstn(rstn),
                                      .data_in(data_in),
                                      .delta(delta)
                                );    

initial forever begin
   #5 clk = ~clk ;
end

initial begin
   clk  = 1'b0;
   data_in = 32'h0; #20;
end

initial
 begin
     $fsdbDumpvars("+fsdbfile+watchdog_timer_driver_test.fsdb","+all");
     rstn = 1'b0; #30;
     rstn = 1'b1; #30;
     repeat(20) @(posedge clk) data_in <= $urandom_range(1000,1002);
   	 $finish;
 end

endmodule