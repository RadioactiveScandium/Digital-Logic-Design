module PISO # (parameter N=5) (
  								input  logic 		 rstn,
  								input  logic 		 clk,
  								input  logic 		 load,
  								input  logic [N-1:0] parallel_in,
  								output logic 		 serial_out 				
							  );
  
logic [N-1:0] parallel_in_reg;
  
always_ff @ (posedge clk or negedge rstn) begin
  	if (~rstn)
      	parallel_in_reg <= 'b0;
    else begin
      if (load)
        parallel_in_reg <= parallel_in;
      else
        parallel_in_reg <= {parallel_in_reg[N-2:0],parallel_in[0]};
    end  
end
      	
  assign serial_out = parallel_in_reg[N-1];
  
endmodule