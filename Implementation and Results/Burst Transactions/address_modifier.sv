// this design in simulation must be compiled with SIM_ONLY define and SVA_ON to enable the assertions

module address_modifier (
                             input  logic                          rstn,
                             input  logic                          clk,
                             input  logic                          burst_en,
                             input  logic [bt_top::ADDR_WIDTH-1:0] addr_in,
                             output logic [bt_top::ADDR_WIDTH-1:0] addr_modified
                         );

localparam int BURST_LEN = bt_top::BURST_LEN;

logic                                burst_en_ff;
logic                                burst_en_posedge;
logic [$clog2(BURST_LEN):0]          addr_track_count;
logic [bt_top::ADDR_WIDTH-1:0]       start_addr;
logic [5:0]                          burst_len_counter;

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
        addr_modified <= 'h0;
    end
    else begin
        if (burst_en) begin
            if(addr_track_count == BURST_LEN) begin
                  addr_track_count <= 'd0;
                  addr_modified <= start_addr;
            end
            else begin 
                  addr_track_count <= addr_track_count + 1;
                  addr_modified <= addr_modified + addr_mod::STRIDE ;  // convert the fixed increment by 1 to a control register programmable value (name it stride)
            end
        end
        else begin
                  addr_track_count <= 'd0;
                  addr_modified <= addr_in;
        end
    end
end : ADDR_INCR_COUNTER



/////////// Assertions //////////

`ifdef SVA_ON
    property burst_en_in_bounds;
      @(posedge clk) (burst_len_counter <= BURST_LEN-1);
    endproperty
    
    burst_en_lt_burst_len: assert property (burst_en_in_bounds) else begin
      $error("Assertion failed: The burst_en signal went high for (%0d) clock cycles consecutively, which is greater than the burst length (%0d)",burst_len_counter, BURST_LEN);
    end
`endif


endmodule                                                  