`timescale 1ns/1ps
module N_bit_DOWN_counter_tb #(parameter LENGTH = 3)();

logic clk,rst;
logic [LENGTH-1:0] out;

N_bit_UP_counter counter_1      (
                                      .clk(clk),
                                      .rst(rst),
                                      .out(out)  
                                  );    

initial begin
   clk = 1'b0;
   rst = 1'b1;
end

initial forever begin
   #1 clk = ~clk ;
end


initial
 begin
     // The $dumpvars is used to dump the changes in the values of nets and registers in a file that is named as its argument. 
     // So below line will dump the changes in a file named test.vcd. The changes are recorded in a file called VCD file that stands for value change dump :
     // $dumpfile("test.vcd");
     //
     // The $dumpvars is used to specify which variables are to be dumped ( in the file mentioned by $dumpfile). 
     // We basically can specify which modules , and which variables in modules will be dumped. The simplest way to use this is to set the level to 0 
     // and module name as the top module ( typically the top testbench module) as in the below line :
     // $dumpvars(0,Four_bit_DOWN_counter_tb);
     // More documentation is available at : http://www.referencedesigner.com/tutorials/verilog/verilog_62.php
   
     rst = 1'b0; #5;
     rst = 1'b1; #30;
     rst = 1'b0; #50;
     rst = 1'b1; #50;
   	 $finish;
 
 end

initial 
 begin
            $display("Reset\t\t\tCount");
            $monitor("%b\t\t\t%b",rst,out);
 end

endmodule
