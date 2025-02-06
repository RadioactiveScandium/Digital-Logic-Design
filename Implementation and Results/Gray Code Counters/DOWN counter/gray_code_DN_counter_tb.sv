`timescale 1ns/1ps
module gray_code_DN_counter_tb #(parameter MOD_VALUE = 8)();

logic clk,rstn;
logic [$clog2(MOD_VALUE)-1:0] gray_count_out;  

gray_code_DN_counter counter_1  (
                                      .clk(clk),
                                      .rstn(rstn),
                                      .gray_count_out(gray_count_out)  
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
     rstn = 1'b0; #15;
     rstn = 1'b1; #30;
     rstn = 1'b0; #50;
     rstn = 1'b1; #100;
   	 $finish;
 end

initial begin
            $display("Sim Time(ps)\t\t\tReset\t\t\tBinary Count\t\tGray Count");
            $monitor("%0t\t\t\t\t%b\t\t\t%b\t\t\t%b",$realtime,rstn,gray_code_DN_counter_tb.counter_1.count_binary,gray_count_out);
end

endmodule