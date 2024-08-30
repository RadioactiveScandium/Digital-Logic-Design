// D flip-flop w/ async reset_n

`define DFF_ARN(q, d, en, clk, rst_n) \
always_ff @(posedge clk or negedge rst_n) begin \
    if (!rst_n) q <= '0; \
    else  if(en)      q <= d; \
    else              q <= q; \   
end