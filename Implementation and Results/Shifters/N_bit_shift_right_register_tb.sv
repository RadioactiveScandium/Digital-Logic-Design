`timescale 1ns/1ps
module shift_right_register_test#(parameter MSB = 4)();
  logic clk, rst, d_t, en;
  logic [MSB-1:0] out;

  shift_right_register dut (
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
     			         $dumpvars(0,shift_right_register_test);
     			         {rst,en,d_t} = 3'b101; #100;
     		           {rst,en,d_t} = 3'b010; #100;
      			       {rst,en,d_t} = 3'b011; #100;
     			         {rst,en,d_t} = 3'b000; #100;
     			         $finish;	
   end
  
  initial 
        begin
          $display("rst\t\ten\t\t\td_t\t\t\tout");
          $monitor("%b\t\t%b\t\t\t%b\t\t\t%b",rst,en,d_t,out);
        end
  
endmodule
