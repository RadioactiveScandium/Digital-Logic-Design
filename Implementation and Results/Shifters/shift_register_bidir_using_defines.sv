// This architecture saves hardware, but puts a limitation to the use case. Usage of defines restricts the mode in which the shifter can be used.
// Using a particular define, the shifter can work only as a right or left shifter or even bypass it altogether. A better approach would be to build a feature where the
// direction of the register too can be controlled. That way, the same register can be used in any of the three modes.

// Control the define using a separate defines.svh file

`timescale 1ns/1ps
module shift_register_bidir_using_defines #(parameter MSB = 4)
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
      else begin
           `ifdef SHIFT_RIGHT                     // RIGHT Shifter
        			out <= {d,out[MSB-1:1]};
      		`endif
      		`ifdef SHIFT_LEFT                       // LEFT Shifter
      				out <= {out[MSB-2:0],d};
      		`endif
      		`ifdef BYPASS                           // NO SHIFT
      				out <= out;
             `endif
      end		
    end
end
  
endmodule
