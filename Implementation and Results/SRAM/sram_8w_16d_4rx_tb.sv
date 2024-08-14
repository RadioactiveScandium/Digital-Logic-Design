`timescale 1ns/1ps
module sram_8w_16d_4rx_test #(parameter WIDTH = 8, DEPTH = 16, ADDR = 16) ();

logic                  clk;      
logic                  rstn;      
logic                  wren;      
logic                  rden;      
logic                  boot_mode; 
logic                  train_mode;
logic [WIDTH-1:0]      data_in; 
logic [ADDR-1:0]       addr;
logic [WIDTH-1:0]      data_out; 
                     
  
sram_8w_16d_4rx sram_8w_16d_4rx_dut (
                                             .rstn(rstn),
                                             .clk(clk),
                                             .wren(wren),
                                             .rden(rden),
                                             .boot_mode(boot_mode),
                                             .train_mode(train_mode),
                                             .data_in(data_in),
                                             .addr(addr),
                                             .data_out(data_out)
                                   );

always #5 clk = ~clk;
  
initial begin
        rstn    = 1'b0;
   		clk     = 1'b0; 
  		wren    = 1'b0;
  		rden    = 1'b0;
        boot_mode = 1'b0;
        train_mode = 1'b0;
  		data_in = 8'h0;
  		addr    = 16'h0;
end	

initial begin
  $fsdbDumpvars("+fsdbfile+async_SRAM_test_8w_16d.fsdb","+all");
  
  /* Releasing the reset */
  #100 rstn = 1'b1; 

  /* Not in boot mode - WR operation */ 

  /* Training mode */ 
  boot_mode = 1'b0; train_mode = 1'b1; wren = 1'b1; #405;

  /* Transaction mode */ 
  boot_mode = 1'b0; train_mode = 1'b0; wren = 1'b1; #205;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'h1, 16'h0}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'h2, 16'h1}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'h3, 16'h2}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'h4, 16'h3}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'h5, 16'h4}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'h6, 16'h5}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'h7, 16'h6}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'h8, 16'h7}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'h9, 16'h8}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'hA, 16'h9}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'hB, 16'hA}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'hC, 16'hB}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'hD, 16'hC}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'hE, 16'hD}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'hF, 16'hE}; #50;
  {wren, rden, data_in, addr} = {1'b1, 1'b0, 8'h10, 16'hF}; #50;
  //{wren, rden, data_in, addr} = {1'b1, 1'b0, 8'h11, 16'h10}; #50; // Invalid Address // 

  /* In boot mode - RD operation */ 
   boot_mode = 1'b1; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'h0}; #50; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'h1}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 16'h2}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 16'h3}; #50; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'h4}; #50; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'h5}; #50; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'h6}; #50; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'h7}; #50; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'h8}; #50; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'h9}; #50; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'hA}; #50; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'hB}; #50; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'hC}; #50; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'hD}; #50; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'hE}; #50; 
  {wren, rden, addr} = {1'b0, 1'b1, 16'hF}; #50; 
  //{wren, rden, addr} = {1'b0, 1'b1, 16'h10}; #50; // Invalid Address // 
  #1000 $finish;	

end

endmodule  