module basic_handshake_requester (
                                       input  logic rstn,
                                       input  logic clk,
                                       input  logic busy,
                                       input  logic valid_in,
                                       input  logic [3:0] data_in,
                                       output logic valid_out,
                                       output logic [3:0] data_sent
                                 );

`define DSIZE 4

/* If requestor and completer are in asynchronous clock domains, busy must be synchronized to the requester clock domain and then used (valid based synchronization) */
/* Only flopping the valid is sufficient and data can be a feedthrough */
always_ff @ (posedge clk or negedge rstn) begin : REQUESTER
      if (~rstn)
         {valid_out,data_sent} <= {1'b0,4'b0};
      else begin
         if (~busy) //initially - at 1st clock cycle
             {valid_out,data_sent} <= {valid_in,data_in};
         else 
             /* here, the data_sent should be held to data_in to maximize, dynamic power savings ; anyways if valid is not there the data won't be honored by the completer */
             {valid_out,data_sent} <= {1'b0,`DSIZE'b0};
      end
end : REQUESTER

endmodule