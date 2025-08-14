// This design in simulation must be compiled with SIM_ONLY define and SVA_ON to enable the assertions

module address_modifier (
                             input  logic                            rstn,
                             input  logic                            clk,
                             input  logic                            burst_en,
                             input  logic [addr_mod::STRIDE_LEN-1:0] stride, // can be programmed only in non-burst mode - no dynamic programming supported
                                                                             // Hardware failsafe for unintentional programming of stride in burst mode is nice to have, but since this can be intercepted by                                                                                 following proper sequence in sotware, the enahncement is de-prioritized 
                             input  logic [bt_top::ADDR_WIDTH-1:0]   addr_in,
                             output logic                            addr_invalid,
                             output logic [bt_top::ADDR_WIDTH-1:0]   addr_modified
                         );

localparam int BURST_LEN = bt_top::BURST_LEN;

logic                            burst_en_ff;
logic                            burst_en_posedge;
logic [$clog2(BURST_LEN):0]      addr_track_count;
logic [bt_top::ADDR_WIDTH-1:0]   start_addr;
logic [5:0]                      burst_len_counter;
logic [bt_top::ADDR_WIDTH-1:0]   addr_modified_tmp;

// Posedge Detection on burst_en
always_ff @ (posedge clk or negedge rstn) begin
    if (~rstn)
        burst_en_ff <= 1'b0;
    else
        burst_en_ff <= burst_en;
end

`ifdef SIM_ONLY
    logic burst_en_2ff;
    always_ff @ (posedge clk or negedge rstn) begin
    if (~rstn)
        burst_en_2ff <= 1'b0;
    else
        burst_en_2ff <= burst_en_ff;
    end

    assign burst_en_posedge = ~burst_en_2ff & burst_en;

`else
    assign burst_en_posedge = ~burst_en_ff & burst_en;
`endif

// Logging the address when burst mode incrementing was initiated
assign start_addr = burst_en_posedge ? addr_in : 'h0;

// TODO : Use burst_len_counter and hook it up to a CSR based debug interface 
// Have a debug interface to log this into some register - for Si-debug
always_ff @ (posedge clk or negedge rstn) begin : BURST_LEN_COUNTER 
  if (~rstn) burst_len_counter <= 'd0; 
  else begin
      if(burst_en) 
          burst_len_counter <= burst_len_counter + 1;
      else 
          burst_len_counter <= 'd0;
  end
end : BURST_LEN_COUNTER 

always_ff @ (posedge clk or negedge rstn) begin : ADDR_INCR_COUNTER 
    if (~rstn) begin
        addr_track_count <= 'd0;
        addr_modified_tmp <= 'h0;
    end
    else begin
        if (burst_en) begin
            if(addr_track_count == BURST_LEN) begin
                  addr_track_count <= 'd0;
                  addr_modified_tmp <= start_addr;
            end
            else begin 
                  addr_track_count <= addr_track_count + 1;
                  addr_modified_tmp <= addr_modified_tmp + stride ;  // convert the fixed increment by 1 to a control register programmable value (name it stride)
            end
        end
        else begin
                  addr_track_count <= 'd0;
                  addr_modified_tmp <= addr_in;
        end
    end
end : ADDR_INCR_COUNTER

// If the product of burst length and programmed stride value is greater than the SRAM depth, then a fixed invalid address is generated (the last address of the SRAM) and propagated to the RAM instance
// Then, this becomes the responsibility of the SW/FW team to ensure that they unintentionally do not access this forbidden address for any R/W operation
// Future work : The forbidden address may be made configurable to a custom value, but doesn't hurt to keep it in the current state also
assign addr_invalid  = ( (BURST_LEN * stride) > bt_top::ADDR_MAX );
assign addr_modified = addr_invalid ? {bt_top::ADDR_WIDTH{1'b1}} : addr_modified_tmp;


/////////// Assertions //////////

// Checking if on-period of burst_en signal is less than or equal to BURST_LEN number of clock cycles
`ifdef SVA_ON
    property burst_en_in_bounds;
      @(posedge clk) (burst_len_counter <= BURST_LEN-1);
    endproperty
    
    burst_en_lt_burst_len: assert property (burst_en_in_bounds) else begin
      $error("Assertion failed: The burst_en signal went high for (%0d) clock cycles consecutively, which is greater than the burst length (%0d)",burst_len_counter, BURST_LEN);
    end
`endif

// Checking if STRIDE is greater than depth of SRAM 
`ifdef SVA_ON
    property stride_in_bounds;
      @(posedge clk) (stride <= bt_top::ADDR_MAX);
    endproperty
    
    stride_value_lt_sram_depth: assert property (stride_in_bounds) else begin
        $error("Assertion failed: The value of stride (%0d) is greater than the end address (%0d), which is invalid",stride, bt_top::ADDR_MAX);
    end 
`endif

// Checking if modified address is out of bounds 
`ifdef SVA_ON
    property address_in_bounds;
      @(posedge clk) ( (BURST_LEN * stride) <= bt_top::ADDR_MAX );
    endproperty
    stride_burstlen_product_lt_sram_depth: assert property (address_in_bounds) else begin
        $error("Assertion failed: The value of stride and burst length product (%0d) is greater than the end address (%0d), which is invalid",(BURST_LEN*stride), bt_top::ADDR_MAX);
    end 
`endif

endmodule                         