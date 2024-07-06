module Four_bit_DOWN_counter #(parameter MOD_VALUE = 32) (
                                  input  logic 							         clk,
                                  input  logic 							         rst,
  								          output logic [($clog2(MOD_VALUE)-1):0]   out  
                             );                       

  
  
always_ff @ (posedge clk or negedge rst) begin  // few compilers like Icarus don't understand always_ff statement, so use always in such cases
      if (~rst)   
         out <= '1;
      else begin
         out <= out - 1;
      end
end 

endmodule 