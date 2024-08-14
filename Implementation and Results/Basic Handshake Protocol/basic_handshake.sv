module basic_handshake (
                                input  logic rstn,
                                input  logic clk,
                                input  logic valid_top,
                                input  logic [3:0] data_sent_top,
                                output logic [3:0] data_rcvd_top
                       );

logic        valid_to_completer;
logic [3:0]  data_to_completer;
logic        busy;


basic_handshake_requester i_requester(
                                          .rstn(rstn),
                                          .clk(clk),
                                          .busy(busy),
                                          .valid_in(valid_top),
                                          .data_in(data_sent_top),
                                          .valid_out(valid_to_completer),
                                          .data_sent(data_to_completer)
                                    );

basic_handshake_completer i_completer (
                                          .rstn(rstn),
                                          .clk(clk),
                                          .valid(valid_to_completer),
                                          .data_in(data_to_completer),
                                          .busy(busy),
                                          .data_rcvd(data_rcvd_top)
                                     );
 
endmodule
