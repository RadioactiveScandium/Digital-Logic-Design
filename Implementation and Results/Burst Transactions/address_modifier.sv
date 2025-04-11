// this design in simulation must be compiled with SIM_ONLY define

module address_modifier #(parameter ADDR_WIDTH=16, BURST_LEN=8)
                         (
                             input  logic                  rstn,
                             input  logic                  clk,
                             input  logic                  burst_en,
                             input  logic [ADDR_WIDTH-1:0] addr_in,
                             output logic [ADDR_WIDTH-1:0] addr_modified
                         );

logic                  burst_en_ff;
logic                  burst_en_posedge;
logic [4:0]            addr_track_count;
logic [ADDR_WIDTH-1:0] start_addr;

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

assign start_addr = burst_en_posedge ? addr_in : 'h0;

always_ff @ (posedge clk or negedge rstn) begin : ADDR_INCR_COUNTER 
    if (~rstn) begin
        addr_track_count <= 'd0;
        addr_modified <= 'h0;
    end
    else begin
        if (burst_en) begin
            if(addr_track_count == BURST_LEN-1) begin
                  addr_track_count <= 'd0;
                  addr_modified <= start_addr;
            end
            else begin 
                  addr_track_count <= addr_track_count + 1;
                  addr_modified <= addr_modified + 1;
            end
        end
        else begin
                  addr_track_count <= 'd0;
                  addr_modified <= addr_in;
        end
    end
end : ADDR_INCR_COUNTER

endmodule