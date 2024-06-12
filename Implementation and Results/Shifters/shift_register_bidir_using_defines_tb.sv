// This architecture saves hardware, but puts a limitation to the use case. Usage of defines restricts the mode in which the shifter can be used.
// Using a particular define, the shifter can work only as a right or left shifter or even bypass it altogether. A better approach would be to build a feature where the
// direction of the register too can be controlled. That way, the same register can be used in any of the three modes.

// Control the define using a separate defines.svh file

`timescale 1ns/1ps
module shift_register_bidir_using_defines_test #(parameter MSB = 4) ();
  logic clk, rst, d_t, en;
  logic [MSB-1:0] out;

  shift_register_bidir_using_defines dut (
   								 .clk(clk),
    							 .rst(rst),
    							 .d(d_t),
    							 .en(en),
  	  							 .out(out)
  							) ;
  		
  always #20 clk = ~clk;

  initial begin
    	clk = 1'b0;
    	rst = 1'b1;
  end
  
   initial begin
                   $dumpfile("test.vcd");
     			   $dumpvars(0,shift_register_bidir_using_defines_test);
     			   {rst,en,d_t} = 3'b101; #100;
     		           {rst,en,d_t} = 3'b010; #100;
      			   {rst,en,d_t} = 3'b011; #100;
     			   {rst,en,d_t} = 3'b111; #100;
     			   {rst,en,d_t} = 3'b000; #100;
     			   $finish;	
   end
  
  initial 
        begin
          $display("rst\t\ten\t\t\td_t\t\t\tout");
          $monitor("%b\t\t%b\t\t\t%b\t\t\t%b",rst,en,d_t,out);
        end
  
endmodule
