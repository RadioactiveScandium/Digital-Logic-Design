module signal_delayer (
                           input  logic          clk,
                           input  logic          rstn,
                           input  logic          sig_in,
                           input  logic  [3:0]   delay_value,
                           output logic          sig_out
                      ); 

logic          sig_out_temp;
logic  [3:0]   count; 



always_ff @ (posedge clk or negedge rstn) begin
   if (~rstn) begin
      sig_out_temp <= 1'b0 ;
      count   <= 0;
   end
   else begin
      if (sig_in) begin
         if (count == delay_value) begin
               sig_out_temp <= sig_in ;
               count   <= 0;
         end
         else begin
               sig_out_temp <= sig_out_temp ;
               count   <= count + 1;
         end
      end
      else begin
         sig_out_temp <= 1'b0 ;
         count <= 0;
      end
   end
end

pulse_stretcher pulse_stretcher_u1 (
                                             .clk(clk), 
                                             .rstn(rstn), 
                                             .delay_value(delay_value),
                                             .pulse_in(sig_out_temp), 
                                             .pulse_out(sig_out)
                                  );

endmodule