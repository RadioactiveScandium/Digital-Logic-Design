/*    
Odd clock divider with division value programmable via software ; maximum division supported is 15 in this case.
This max division value can be increased by expanding the width of the signal divbyvalue.
*/

module clkdivbyn_odd (
                         input  logic        rstn,
                         input  logic        clkin,
                         input  logic [3:0]  divbyvalue,
                         output logic        clkout
                     );

logic [3:0]  count_pos;
logic [3:0]  count_neg;
logic [3:0]  divbyvalue_rshifted;

assign divbyvalue_rshifted = divbyvalue>>1; 

always_ff @ (posedge clkin or negedge rstn) begin
   if (~rstn) begin
      count_pos <= 'b0;
   end
   else begin 
      if(count_pos == (divbyvalue-1))
         count_pos <= 'b0;
      else 
         count_pos <= count_pos + 1;
   end 
end

always_ff @ (negedge clkin or negedge rstn) begin
   if (~rstn) begin
      count_neg <= 'b0;
   end
   else begin 
      if(count_neg == (divbyvalue-1))
         count_neg <= 'b0;
      else 
         count_neg <= count_neg + 1;
   end 
end

assign clkout = ((count_pos > divbyvalue_rshifted) | (count_neg > divbyvalue_rshifted)) ; 

endmodule
