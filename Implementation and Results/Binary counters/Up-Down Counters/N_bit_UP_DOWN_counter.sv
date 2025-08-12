module counter_nbit_up_down #(parameter WIDTH = 3)	
                                                 (
  											         input  logic             clk, 
  											         input  logic             rstn,
                                                     input  logic             direction,
  											         output logic [WIDTH-1:0] count_out 
										         );
 
always_ff @ (posedge clk or negedge rstn) begin
     if(~rstn)
         count_out <= direction ? {WIDTH{1'b1}} : {WIDTH{1'b0}} ;
     else 
         count_out <= direction ? (count_out + 1) : (count_out - 1) ;
end

endmodule