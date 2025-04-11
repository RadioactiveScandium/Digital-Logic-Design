`timescale 1ns/1ps
module burst_transaction_top_test #(parameter ADDR_WIDTH=16, DATA_WIDTH=8, BURST_LEN=8) ();

logic                  rstn;
logic                  clk;
logic                  burst_en;
logic [ADDR_WIDTH-1:0] addr_top;
logic                  wren;  
logic                  rden;  
logic [DATA_WIDTH-1:0] wr_data;
logic [DATA_WIDTH-1:0] rd_data;

burst_transaction_top  dut (
                              .rstn(rstn),
                              .clk(clk),
                              .burst_en(burst_en),
                              .addr_top(addr_top),
                              .wren(wren),
                              .rden(rden),
                              .wr_data(wr_data),
                              .rd_data(rd_data)
                           );

always #5 clk = ~clk;

initial begin
    rstn = 1'b0; clk  = 1'b0; burst_en = 1'b0; addr_top = 'h0; wren = 1'b0; rden = 1'b0; wr_data = 8'h0;
    #30;
end

initial begin
    $fsdbDumpvars("+fsdbfile+burst_transaction_top_test.fsdb","+all");
    #20 rstn = 1'b1; wren = 1'b1; #25;
    // Write Operation
    @(posedge clk) addr_top = 'h1 ;  wr_data = 8'h11; @(posedge clk) addr_top = 'h2 ;  wr_data = 8'h12; @(posedge clk) addr_top = 'h3 ;  wr_data = 8'h13; 
    @(posedge clk) addr_top = 'h4 ;  wr_data = 8'h14; @(posedge clk) addr_top = 'h5 ;  wr_data = 8'h15; @(posedge clk) addr_top = 'h6 ;  wr_data = 8'h16;
    // Burst Enabled
    @(posedge clk) addr_top = 'h7 ;  wr_data = 8'h17; burst_en = 1'b1;
    @(posedge clk) burst_en = 1'b1;  wr_data = 8'h18; 
    @(posedge clk) burst_en = 1'b1;  wr_data = 8'h19; 
    @(posedge clk) burst_en = 1'b1;  wr_data = 8'h1A; 
    @(posedge clk) burst_en = 1'b1;  wr_data = 8'h1B; 
    @(posedge clk) burst_en = 1'b1;  wr_data = 8'h2B; 
    @(posedge clk) burst_en = 1'b1;  wr_data = 8'h3B; 
    // Burst Disabled
    @(posedge clk) addr_top = 'h12 ; wr_data = 8'h1C; burst_en = 1'b0;
    @(posedge clk) addr_top = 'h13 ; wr_data = 8'h1D; @(posedge clk) addr_top = 'h14 ; wr_data = 8'h1E;
    @(posedge clk) addr_top = 'h15 ; wr_data = 8'h1F; @(posedge clk) addr_top = 'h16 ; wr_data = 8'h10;

    // Read Operation
    @(posedge clk) burst_en = 1'b0;  rden = 1'b1;  wren = 1'b0;
    @(posedge clk) addr_top = 'h0 ;  @(posedge clk) addr_top = 'h1 ;  @(posedge clk) addr_top = 'h2 ;  
    @(posedge clk) addr_top = 'h3 ;  @(posedge clk) addr_top = 'h4 ;  @(posedge clk) addr_top = 'h5 ;  
    @(posedge clk) addr_top = 'h6 ;  @(posedge clk) addr_top = 'h7 ;  burst_en = 1'b1;
    // Burst Enabled
    @(posedge clk) burst_en = 1'b1;  @(posedge clk) burst_en = 1'b1;  @(posedge clk) burst_en = 1'b1;  @(posedge clk) burst_en = 1'b1;  
    // Burst Disabled
    @(posedge clk) burst_en = 1'b0; addr_top = 'hc ;  
    @(posedge clk) addr_top = 'hd ;  @(posedge clk) addr_top = 'h12 ;
    @(posedge clk) addr_top = 'h15 ;  @(posedge clk) addr_top = 'h16 ;  
    @(posedge clk) addr_top = 'h13 ;  @(posedge clk) addr_top = 'h14 ;
    $finish;
end

endmodule