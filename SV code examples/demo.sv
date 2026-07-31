module demo ( 
   input logic a,
  output logic b,
  input logic clk,
  input logic rstn
       );

  always_ff @ (posedge clk or negedge rstn) begin
    if (~rstn) b <= 1'b0;
  else b <= a;
  end

  
endmodule
