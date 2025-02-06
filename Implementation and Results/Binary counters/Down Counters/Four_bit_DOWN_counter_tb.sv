`timescale 1ns/1ps
module N_bit_DOWN_counter_tb #(parameter MOD_VALUE = 8)();

logic clk,rstn;
logic [$clog2(MOD_VALUE)-1:0] out;  

N_bit_DOWN_counter counter_1      (
                                      .clk(clk),
                                      .rstn(rstn),
                                      .out(out)  
                                  );    

initial begin
   clk = 1'b0;
   rstn = 1'b1;
end

initial forever begin
   #5 clk = ~clk ;
end

initial
 begin
     // The $dumpvars is used to dump the changes in the values of nets and registers in a file that is named as its argument. 
     // So below line will dump the changes in a file named test.vcd. The changes are recorded in a file called VCD file that stands for value change dump :
     $dumpfile("test.vcd");
     //
     // The $dumpvars is used to specify which variables are to be dumped ( in the file mentioned by $dumpfile). 
     // We basically can specify which modules , and which variables in modules will be dumped. The simplest way to use this is to set the level to 0 
     // and module name as the top module ( typically the top testbench module) as in the below line :
     $dumpvars(0,Four_bit_DOWN_counter_tb);
     // More documentation is available at : http://www.referencedesigner.com/tutorials/verilog/verilog_62.php   
     rstn = 1'b0; #15;
     rstn = 1'b1; #30;
     rstn = 1'b0; #50;
     rstn = 1'b1; #100;
   	 $finish;
 end

initial begin
            $display("Sim Time(ps)\t\t\tReset\t\t\tCount");
            $monitor("%0t\t\t\t\t%b\t\t\t%b\t\t",$realtime,rstn,out);
end

endmodule