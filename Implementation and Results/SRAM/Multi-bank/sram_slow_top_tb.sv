`timescale 1ns/1ps
module sram_slow_top_test #( parameter int WIDTH = 16, parameter int DEPTH = 1024) ();

logic                     rstn;  
logic                     clk;  
//logic                     sel;
logic                     wren;  
logic                     rden;  
logic [$clog2(DEPTH)-1:0] addr;
logic [WIDTH-1:0]         wr_data;
logic [WIDTH-1:0]         rd_data;

sram_slow_top #(.WIDTH(16), .DEPTH(1024)) dut
             ( 
                .rstn(rstn),
                .clk(clk),
                //.sel(sel),
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
        //sel     = 1'b0;
  		wren    = 1'b0;
  		rden    = 1'b0;
  		wr_data = 32'h0;
  		addr = 10'b0; #200;
end	

initial begin
  $fsdbDumpvars("+fsdbfile+sram_slow_top_test.fsdb","+all");
  
  /* Releasing the reset */
  #100 rstn = 1'b1;
  #15;
  /* Write mode */
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 16'h10, 10'd0};   #10;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 16'h11, 10'd256}; #10;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 16'h12, 10'd512}; #10;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 16'h13, 10'd768}; #10;

  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 16'h20, 10'd255}; #10;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 16'h21, 10'd511}; #10;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 16'h22, 10'd767}; #10;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 16'h23, 10'd1023};#10;

  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 16'h30,  10'd120}; #10;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 16'h31,  10'd420}; #10;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 16'h32,  10'd620}; #10;
  {wren, rden, wr_data, addr} = {1'b1, 1'b0, 16'h33,  10'd1020};#10;

  /* Read mode */
  {wren, rden, addr} = {1'b0, 1'b1, 10'd0};    #10;
  {wren, rden, addr} = {1'b0, 1'b1, 10'd1023}; #10;
  {wren, rden, addr} = {1'b0, 1'b1, 10'd768}; #10;
  {wren, rden, addr} = {1'b0, 1'b1, 10'd620};  #10;
  {wren, rden, addr} = {1'b0, 1'b1, 10'd420};  #10;

  $finish;
end

endmodule