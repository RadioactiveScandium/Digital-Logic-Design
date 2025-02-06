`timescale 1ns/1ps

module N_bit_UP_counter  # (parameter MOD_VALUE = 8)    (                                          
                                                            input logic clk,
                                                            input logic rstn,
                                                            output logic [$clog2(MOD_VALUE)-1:0] out  
                          	                            );

always_ff @ (posedge clk or negedge rstn) begin
      if (~rstn)   
         out <= 'b0;
      else begin
         if(out == MOD_VALUE-1)
             out <= {(MOD_VALUE-1){1'b0}};
         else
             out <= out + 1;
      end
end

endmodule
