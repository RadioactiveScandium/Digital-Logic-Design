`timescale 1ns/1ps                // to ensure tight compatibility between TB and design timescales
`default_nettype none
module Four_bit_UP_counter(
                                  input logic clk,
                                  input logic rst,
                                  output logic [3:0] out  
                          );                    

  always_ff @ (posedge clk or negedge rst) begin  // compilers without SV support don't understand always_ff statement, so use always in such cases
      if (~rst)   
         out <= 'b0;
      else begin
         out <= out + 1;
      end
end


endmodule 
