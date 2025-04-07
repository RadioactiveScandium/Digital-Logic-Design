`timescale 1ns/1ps
module WDT_top_test #(parameter DATA_WIDTH = 32, MAX_COUNT=32)();

logic                  clk;
logic                  rstn;
logic [DATA_WIDTH-1:0] data_in;
logic                  interrupt_top;

WDT_top driver_dut(
                     .clk(clk),
                     .rstn(rstn),
                     .data_in(data_in),
                     .interrupt_top(interrupt_top)
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
     $fsdbDumpvars("+fsdbfile+WDT_top_test.fsdb","+all");
     rstn = 1'b0; #30;
     rstn = 1'b1; #30;
     @(posedge clk) data_in <= 32'hA; @(posedge clk) data_in <= 32'hC; @(posedge clk) data_in <= 32'hE;
     @(posedge clk) data_in <= 32'hF; @(posedge clk) data_in <= 32'hA; @(posedge clk) data_in <= 32'hA;
     @(posedge clk) data_in <= 32'hA; @(posedge clk) data_in <= 32'hA; @(posedge clk) data_in <= 32'hA;
     @(posedge clk) data_in <= 32'hA; @(posedge clk) data_in <= 32'hA; @(posedge clk) data_in <= 32'hA;
     @(posedge clk) data_in <= 32'hA; @(posedge clk) data_in <= 32'hA; @(posedge clk) data_in <= 32'hA;
     @(posedge clk) data_in <= 32'hF; @(posedge clk) data_in <= 32'hF; @(posedge clk) data_in <= 32'hF;
   	 $finish;
 end

endmodule