module watchdog_timer_driver #(parameter DATA_WIDTH=32) 
                              (
                                     input logic                  rstn,
                                     input logic                  clk,
                                     input logic                  intr,
                                     input logic [DATA_WIDTH-1:0] data_in,
                                     output logic                 delta
                              );

logic [DATA_WIDTH-1:0] prev_data_in;

// Introducing the interrupt here :
// Staged approach - 1. if (!intr) prev_data_in <= data_in;                      ----> DONE
//                      else prev_data_in <= prev_data_in; 
//                   2. Clk gate the flop using interrupt as the gating enable

always_ff @ (posedge clk or negedge rstn) begin
    if(~rstn)
           prev_data_in <= 'd0;
    else
           prev_data_in <= ~intr ? data_in : prev_data_in;
end

assign delta = (prev_data_in == data_in) ;

endmodule