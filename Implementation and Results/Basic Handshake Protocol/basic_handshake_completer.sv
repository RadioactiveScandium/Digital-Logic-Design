module basic_handshake_completer (
                                    input  logic rstn,
                                    input  logic clk,
                                    input  logic valid,
                                    input  logic [3:0] data_in,
                                    output logic busy,
                                    output logic [3:0] data_rcvd
                                 );

/* If requestor and completer are in asynchronous clock domains, valid must be synchronized to the completer clock domain and then used (valid based synchronization) */
always_ff @ (posedge clk or negedge rstn) begin : COMPLETER
      if (~rstn)
         {data_rcvd,busy} <= {4'b0,1'b0};
      else begin
         if (valid)
            {data_rcvd,busy} <= {data_in,1'b1};
         else 
            {data_rcvd,busy} <= {4'b0,1'b0};
      end
end : COMPLETER


endmodule