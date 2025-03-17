`include "Implementation and Results/Macros/flop_macro.svh"

module pipeline_flops #(parameter NUM_STAGES=3, DATA_WIDTH=16) ( 
                  input  logic                   rstn,
                  input  logic                   clk,
                  input  logic  [DATA_WIDTH-1:0] inp,
                  output logic  [DATA_WIDTH-1:0] out_top
           );

logic [DATA_WIDTH-1:0] outp [NUM_STAGES:0];

`DFF_ARN(outp[0], inp,   1'b1, clk, rstn);

generate
 for (genvar i = 0 ; i < NUM_STAGES  ; i = i+1)
   `DFF_ARN(outp[i+1], outp[i], 1'b1, clk, rstn);
endgenerate

assign out_top = outp[NUM_STAGES];

endmodule