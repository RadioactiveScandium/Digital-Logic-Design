`timescale 1ns/1ps
module shift_right_register #(parameter MSB = 4)
  							(
  								input logic clk,
  								input logic rst,
  								input logic d,
  								input logic en,
                  						output logic [MSB-1:0] out
					  		);	
  
always @ (posedge clk or posedge rst) begin
    if (rst)
      		out <= 4'b1011;
  	else begin
              if (~en)
        	            out <= out;
              else
		      // for left shifting : out <= {out[MSB-2:0],d}
		      out <= {d,out[MSB-1:1]};
    end
end
  
endmodule
