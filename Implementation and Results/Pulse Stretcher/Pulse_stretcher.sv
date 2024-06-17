module pulse_stretcher ( 
                           input logic            clk, 
						   input logic            rstn, 
                           input logic            in, 
                           input  logic  [3:0]    delay_value,
                           output logic           pulse_out 
                       ); 


logic       in_ff;
logic       in_posedge;
logic       pulse_out_f; 
logic [3:0] count_pulse;
  
always_ff @ (posedge clk or negedge rstn) begin 
      if (~rstn) 
         in_ff <= 1'b0;
      else 
         in_ff <= in;  
end
  
assign in_posedge = in & ~in_ff;

always_ff @ (posedge clk or negedge rstn) begin 
      if (~rstn) begin 
         count_pulse <= 4'b0; 
         pulse_out_f <= 1'b0; 
      end else  begin 
            if (in_posedge) begin  
               count_pulse <= delay_value; /* only once */ 
            end 
            if (count_pulse > 0) begin 
               count_pulse <= count_pulse - 1; 
               pulse_out_f <= 1'b1; 
            end else begin 
               pulse_out_f <= 1'b0; 
            end  
      end 
end 

assign pulse_out = pulse_out_f;

endmodule