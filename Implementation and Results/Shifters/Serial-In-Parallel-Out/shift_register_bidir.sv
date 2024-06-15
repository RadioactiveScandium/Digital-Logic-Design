`timescale 1ns/1ps
module shift_register_bidir #(parameter MSB = 4)
  							(
  								input logic clk,
  								input logic rst,
  								input logic d,
  								input logic en,
                              	input logic direction,
                              	output logic [MSB-1:0] out
					  		);	
  
  always @ (posedge clk or posedge rst) begin
    if (rst)
      		out <= 4'b1011;
  	else begin
      if (~en)
        	out <= out;
      else begin
        case(direction)
          1 : out <= {d,out[MSB-1:1]};  // RIGHT shifter
          0 : out <= {out[MSB-2:0],d};  // LEFT shifter
        endcase  
      end		
    end
end
  
endmodule   
