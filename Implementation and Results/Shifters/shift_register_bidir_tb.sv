`timescale 1ns/1ps
module shift_register_bidir_test #(parameter MSB = 4) ();
  logic clk, rst, d_t, en,dir;
  logic [MSB-1:0] out;

  shift_register_bidir dut (
   								 .clk(clk),
    							 .rst(rst),
    							 .d(d_t),
    							 .en(en),
    							 .direction(dir),
  	  							 .out(out)
  							) ;
  		
  always #20 clk = ~clk;

  initial begin
    	clk = 1'b0;
    	rst = 1'b1;
  end
  
   initial begin
                   $dumpfile("test.vcd");
     			   $dumpvars(0,shift_register_bidir_test);
     {rst,en,d_t,dir} = 4'b1011; #100;
     {rst,en,d_t,dir} = 4'b0100; #100;
     {rst,en,d_t,dir} = 4'b0111; #100;
     {rst,en,d_t,dir} = 4'b0110; #100;
     {rst,en,d_t,dir} = 4'b0001; #100;
     			   $finish;	
   end
  
  initial 
        begin
          $display("rst\t\ten\t\t\td_t\t\tdir\t\t\tout");
          $monitor("%b\t\t%b\t\t\t%b\t\t%b\t\t\t%b",rst,en,d_t,dir,out);
        end
  
endmodule
