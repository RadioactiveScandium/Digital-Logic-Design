`timescale 1ns/1ps
module round_robin_arbiter_test ();
  
logic       rstn;
logic       clk;
logic [3:0] req;
logic [3:0] grant;
  
round_robin_arbiter RRA (.*);

always #5 clk = ~clk;
  
initial begin
  rstn = 1'b0;
  clk  = 1'b0;
  req  = 4'b0; #20;
end
  
initial begin
  $fsdbDumpvars("+fsdbfile+round_robin_arbiter_test.fsdb","+all");
  rstn = 1'b1; #10;
  req  = 4'b0001; #10;
  req  = 4'b0010; #10;
  req  = 4'b0100; #10;
  req  = 4'b1000; #10;
  #20;
  $finish;
end
  
endmodule