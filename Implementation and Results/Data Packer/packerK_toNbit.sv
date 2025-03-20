`include "Implementation and Results/Macros/flop_macro.svh"

module packerK_toNbit #(parameter FACTOR = 3,IN_WIDTH=8)(
                              input  logic                    rstn, 
                              input  logic                    clk,
                              input  logic [IN_WIDTH-1:0]     data_in,
                              output logic [(FACTOR*IN_WIDTH)-1:0] data_out
                       );

logic [FACTOR-1:0]       count;
logic                    count_done;
logic [IN_WIDTH-1:0]     data_tmp[FACTOR-1:0]; 

always_ff @ (posedge clk or negedge rstn) begin : MOD_FACTOR_COUNTER
   if (~rstn)
      {count,count_done}  <= {1'b0,1'b0};
   else begin
      if (count == FACTOR-1)
            {count,count_done} <= {1'b0,1'b1};
      else  
            {count,count_done} <= {(count+1),1'b0};
   end
end

`DFF_ARN(data_tmp[0], data_in, 1'b1, clk, rstn);

generate
 for (genvar i = 0 ; i < FACTOR-1  ; i = i+1)
    `DFF_ARN(data_tmp[i+1], data_tmp[i], 1'b1, clk, rstn);
endgenerate

/* Unpacking the data into 1-D */
logic [(FACTOR*IN_WIDTH)-1:0] data_out_tmp_1D;

always_comb begin
    for (integer i = FACTOR-1 ; i >= 0 ; i = i-1)
        data_out_tmp_1D = {data_out_tmp_1D, data_tmp[i]};
end

assign data_out = count_done ? data_out_tmp_1D : {(FACTOR*IN_WIDTH){'b0}};

endmodule