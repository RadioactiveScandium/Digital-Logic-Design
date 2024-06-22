module icg_cell (
                  input  logic clk_in,
                  input  logic en,
  				  input  logic active_value,
                  output logic clk_gated
                );

logic latch_out;

always_latch begin
   if (~clk_in)
      latch_out <= en;
end

always_comb begin
		case(active_value)
  			0 : clk_gated =  latch_out & clk_in; /* gates the clock when the enable is low */
 			1 : clk_gated = ~latch_out & clk_in; /* gates the clock when the enable is high */
		endcase
end  
  
endmodule