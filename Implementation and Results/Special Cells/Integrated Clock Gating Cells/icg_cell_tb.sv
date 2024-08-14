`timescale 1ns/1ps
module icg_cell_test ();

logic clk_in;
logic en;
logic clk_gated;
logic active_value;  

always #5 clk_in = ~clk_in;

icg_cell icg_cell_u1 (
  						.clk_in(clk_in),
  					    .en(en),
  						.clk_gated(clk_gated),
  						.active_value(active_value) 
  					 );

initial begin
   en     = 1'b0;
   clk_in = 1'b0;
   active_value = 1'b1;
end

initial begin
   $dumpfile("test.vcd");
   $dumpvars(0,icg_cell_test);
   en = 1'b0; #20;
   en = 1'b1; #60;
   en = 1'b0; #75;
   en = 1'b1; #57;
   en = 1'b0; #38;
   en = 1'b1; #57;
   en = 1'b0; #24;
   en = 1'b1; #57;
   en = 1'b0; #15;
   en = 1'b1; #57;
   en = 1'b0; #15;
   $finish;
end

endmodule