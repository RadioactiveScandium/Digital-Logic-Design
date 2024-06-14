// Compilation with the macro MEALY_MACHINE results in Mealy implementation, otherwise MOORE machine is considered
module nonoverlap_1010 (
                          input   logic  clk,
                          input   logic  rstn,
                          input   logic  in,
                          output  logic  out
                       );

`ifdef MEALY_MACHINE
enum logic [1:0] {S1,S10,S101,S1010}     state,next_state;
`else
enum logic [2:0] {S1,S10,S101,S1010,END} state,next_state;
`endif  

always_ff@(posedge clk or negedge rstn) begin : STATE_MOVEMENT_FLOP
   if (~rstn)
      state <= S1;
   else 
      state <= next_state;
end

always_comb begin
   case (state)
      S1      : next_state = (in == 0) ? S1   : S10;
      S10     : next_state = (in == 0) ? S101 : S10;
      S101    : next_state = (in == 0) ? S1   : S1010;
      `ifdef MEALY_MACHINE
      S1010   : next_state = (in == 0) ? S1   : S10;
      `else
      S1010   : next_state = (in == 0) ? END   : S10;
      END     : next_state = (in == 0) ? S1    : S10;
      `endif
      default : next_state = S1;
   endcase
end

`ifdef MEALY_MACHINE
      assign out = ((state == S1010) && (in == 1'b0)) ? 1'b1 : 1'b0;
`else
      assign out = (state == END) ? 1'b1 : 1'b0;
`endif

endmodule
