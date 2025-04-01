/*
Design for pulse generator. Takes an input sample and generates a corresponding pulse based on whether Rising edge, Falling edge or Either edge functionality 
is selected via relevant defines. Exact same logic cane be used in edge detection applications.
*/
module pulse_det (
  					input  logic sig,
  					input  logic clk,
  					input  logic rstn,
  					output logic pulse_sig
				  );
  
logic gate;
  
always_ff @ (posedge clk or negedge rstn) begin
    if (~rstn)
       gate <= 0;
    else 
       gate <= sig;
end
 
`ifdef RISING_PULSE_DET
        assign pulse_sig = ~gate & sig;
`elsif FALLING_PULSE_DET
        assign pulse_sig = gate & ~sig;
`else
	assign pulse_sig = gate ^ sig;
`endif
  
endmodule