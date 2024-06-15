module pisotb #(parameter N=5) ();

logic 		  rstn;
logic 		  clk;
logic 		  load;
logic [N-1:0] parallel_in;
logic 		  serial_out; 	  
 
PISO PISO_u1 ( 
  				.rstn(rstn),
  				.clk(clk),
  				.load(load),
 				.parallel_in(parallel_in),
 				.serial_out(serial_out)			 
             );   

always #5 clk = ~clk;  
  
initial 
    begin
      clk  = 1'b0;
      rstn = 1'b0;
      load = 1'b0;
      parallel_in = 'b0;
end
  
 initial 
    begin
      $dumpfile("pisotb.vcd");
      $dumpvars(0,pisotb);
      #10;  rstn=1;
      #10;  load=1;parallel_in=5'b10101;
      #10;  load=0;
      #100 $finish;
    end


endmodule  