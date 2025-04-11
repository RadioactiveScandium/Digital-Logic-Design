module burst_transaction_top #(parameter ADDR_WIDTH=16, DATA_WIDTH=8, BURST_LEN=8 )
                              (
                                  input  logic                  rstn,
                                  input  logic                  clk,
                                  input  logic                  burst_en,
                                  input  logic [ADDR_WIDTH-1:0] addr_top,
                                  input  logic                  wren,  
                                  input  logic                  rden,  
                                  input  logic [DATA_WIDTH-1:0] wr_data,
                                  output logic [DATA_WIDTH-1:0] rd_data
                              );

logic [ADDR_WIDTH-1:0] addr_from_gen;

address_modifier address_gen(
                                 .rstn(rstn),
                                 .clk(clk),
                                 .burst_en(burst_en),
                                 .addr_in(addr_top),
                                 .addr_modified(addr_from_gen)
                            );


sram sram_i (
                  .rstn(rstn),   
                  .clk(clk),  
                  .wren(wren),  
                  .rden(rden),  
                  .addr(addr_from_gen),
                  .wr_data(wr_data),
                  .rd_data(rd_data)
            );

endmodule