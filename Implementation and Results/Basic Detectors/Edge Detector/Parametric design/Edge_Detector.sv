/*
Design for pulse generator. Takes an input sample and generates a corresponding pulse based on whether Rising edge, Falling edge or Either edge functionality is selected via the DET_TYPE parameter. 
Exact same logic can be used in edge detection applications.
*/
module pulse_det #(parameter DET_TYPE=1)  (
  					                                input  logic        rstn,
  					                                input  logic        clk,
  					                                input  logic        sig,
  					                                output logic        pulse_sig
				                          );
  
logic gate;
  
always_ff @ (posedge clk or negedge rstn) begin
    if (~rstn)
            gate <= 1'b0;
    else 
            gate <= sig ; 
end

generate
     always_comb begin : DETECTOR_SELECTION
         if      (DET_TYPE == 1)
                     pulse_sig = ~gate &  sig; // Posedge Detection
         else if (DET_TYPE == 2)
                     pulse_sig =  gate &  ~sig;// Negedge Detection
         else if (DET_TYPE == 3)
                     pulse_sig =  gate ^  sig; // Dual-edge Detection
         else
                     pulse_sig = ~gate &  sig; // Default : Posedge Detection
     end  
endgenerate

endmodule