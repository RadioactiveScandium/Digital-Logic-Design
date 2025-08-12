// Compile this design with the define SIM_ONLY for DV purpose
module burst_transaction_top (
                                  input  logic                          rstn,
                                  input  logic                          clk,
                                  input  logic                          burst_en,
                                  input  logic [bt_top::ADDR_WIDTH-1:0] addr_top,
                                  input  logic                          wren,  
                                  input  logic                          rden,  
                                  input  logic [bt_top::DATA_WIDTH-1:0] wr_data,
                                  output logic [bt_top::DATA_WIDTH-1:0] rd_data
                             );

logic [bt_top::ADDR_WIDTH-1:0] addr_from_gen;

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

/////////// Assertions //////////

// Checking if STRIDE is greater than depth of SRAM 
`ifdef SVA_ON
    property stride_in_bounds;
      @(posedge clk) (addr_mod::STRIDE <= bt_top::ADDR_MAX);
    endproperty
    
    stride_value_lt_sram_depth: assert property (stride_in_bounds) else begin
        $error("Assertion failed: The value of stride (%0d) is greater than the end address (%0d), which is invalid",addr_mod::STRIDE, bt_top::ADDR_MAX);
    end 
`endif

endmodule