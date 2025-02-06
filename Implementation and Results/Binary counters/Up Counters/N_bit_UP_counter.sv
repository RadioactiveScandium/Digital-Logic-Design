`timescale 1ns/1ps
always_ff @ (posedge clk or negedge rstn) begin
      if (~rstn)   
         out <= 'b0;
      else begin
         if(out == MOD_VALUE-1)
             out <= 'b0;
         else
             out <= out + 1;
      end
end

endmodule
