`timescale 1ns/1ps
module sram_test #( parameter int WIDTH = 32, parameter int DEPTH = 1024) ();

logic                     rstn;  
logic                     clk;  
logic                     wren;  
logic                     rden;  
logic [$clog2(DEPTH)-1:0] addr;
logic [WIDTH-1:0]         wr_data;
logic [WIDTH-1:0]         rd_data;

sram #(.WIDTH(32), .DEPTH(1024)) dut
             ( 
                .rstn(rstn),
                .clk(clk),
                .wren(wren),
                .rden(rden),
                .addr(addr),
                .wr_data(wr_data),
                .rd_data(rd_data)
             );

always #5 clk = ~clk;
  
initial begin
        rstn    = 1'b0;
   		clk     = 1'b0; 
  		wren    = 1'b0;
  		rden    = 1'b0;
  		wr_data = 32'h0;
  		addr    = 10'b0; #200;
end	

initial begin
  $fsdbDumpvars("+fsdbfile+sram_test.fsdb","+all");
  
  /* Releasing the reset */
  #100 rstn = 1'b1; 

  /* Write mode */
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h1, 10'h0}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h2, 10'h1}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h3, 10'h2}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h4, 10'h3}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h5, 10'h4}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h6, 10'h5}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h7, 10'h6}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h8, 10'h7}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h9, 10'h8}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h10, 10'h9}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h11, 10'hA}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h12, 10'hB}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h13, 10'hC}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h14, 10'hD}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'h15, 10'hE}; #50;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 32'hAA, 10'h3FF}; #50;

  /* Read mode */
  {wren, rden, addr} = {1'b0, 1'b1, 10'h0}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h1}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h2}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h3}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h4}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h5}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h6}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h7}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h8}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h9}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'hA}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'hB}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'hC}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'hD}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'hE}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h3FF}; #50;

  #100;

  /* Partial memory corruption test */
  {wren, rden, addr} = {1'b1, 1'b1, 10'h0}; #50;
  {wren, rden, addr} = {1'b1, 1'b1, 10'h1}; #50;
  {wren, rden, addr} = {1'b1, 1'b1, 10'h2}; #50;
  {wren, rden, addr} = {1'b1, 1'b1, 10'h3}; #50;
  {wren, rden, addr} = {1'b1, 1'b1, 10'h4}; #50;
  {wren, rden, addr} = {1'b1, 1'b1, 10'h5}; #50;
  {wren, rden, addr} = {1'b1, 1'b1, 10'h6}; #50;

  /* Read mode */
  {wren, rden, addr} = {1'b0, 1'b1, 10'h0}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h1}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h2}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h3}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h4}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h5}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h6}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h7}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h8}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h9}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'hA}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'hB}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'hC}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'hD}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'hE}; #50;
  {wren, rden, addr} = {1'b0, 1'b1, 10'h3FF}; #50;
  $finish;
end

endmodule