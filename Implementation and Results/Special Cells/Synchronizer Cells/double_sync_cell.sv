module double_sync_cell (
                              input logic  rstn,
                              input logic  clk,
                              input logic  d,
                              output logic o
                        );

logic o_stg1;
logic o_stg2;

always_ff @ (posedge clk or negedge rstn) begin
   if (~rstn) begin
        o_stg1  <= 1'b0;
        //o_stg2  <= 1'b0;
   end
   else begin 
        o_stg1  <= d;
        //o_stg2  <= o_stg1;
   end
end

always_ff @ (posedge clk or negedge rstn) begin
   if (~rstn)
       o_stg2  <= 1'b0;
   else
       o_stg2  <= o_stg1;
end

assign o = o_stg2;

endmodule