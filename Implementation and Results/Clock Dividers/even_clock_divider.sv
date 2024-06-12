/*    
Even clock divider with division value programmable via software ; below is the look-up table :
divbyvalue = 3'b000; --> by 2
divbyvalue = 3'b001; --> by 4
divbyvalue = 3'b010; --> by 6
divbyvalue = 3'b011; --> by 8
divbyvalue = 3'b100; --> by 10
divbyvalue = 3'b101; --> by 12
divbyvalue = 3'b110; --> by 14
divbyvalue = 3'b111; --> by 16 (MAX)
*/

module clkdiv_even (
                     input logic        rstn,
                     input logic        clkin,
                     input logic [2:0]  divbyvalue,
                     output logic       clkout

                 );

logic [2:0]  count;

always_ff @ (posedge clkin or negedge rstn) begin
   if (~rstn) begin
      count <= 'b0;
      clkout <= 1'b0;
   end
   else begin 
      if(count == divbyvalue) begin
         count <= 'b0;
        clkout <= ~clkout;  
      end
      else 
         count <= count + 1;
   end 
end

endmodule
