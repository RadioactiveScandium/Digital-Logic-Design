module pulse_stretcher_test ();
 
logic  clk; 
logic  rstn; 
logic  in; 
logic  [3:0] delay_value;
logic  pulse_out;
  
  pulse_stretcher pulse_stretcher(.*);
  
always #5 clk = ~clk;

  
initial begin
  clk  		  = 1'b0;
  rstn 		  = 1'b0;
  in   		  = 1'b0;
  delay_value = 4'b0;#20;
end
  
initial begin
  $dumpfile("test.vcd");
  $dumpvars(0,pulse_stretcher_test);
  rstn = 1'b1; #10;
  in = 1'b1; delay_value = 4'b1100; #30;
  in = 1'b0; #10;
  #150;
  $finish;
end
  
endmodule