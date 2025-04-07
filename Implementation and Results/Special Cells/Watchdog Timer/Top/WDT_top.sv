module WDT_top #(
                  parameter MAX_COUNT=32, 
                  parameter DATA_WIDTH = 32
                )
                (
                    input  logic                  rstn,
                    input  logic                  clk,
                    input  logic [DATA_WIDTH-1:0] data_in,
                    output logic                  interrupt_top 
                );

logic flag_from_driver;
logic interrupt_to_driver;

watchdog_timer wdt(
                     .rstn(rstn),
                     .clk(clk),
                     .flag(flag_from_driver),
                     .interrupt(interrupt_to_driver)
                   );


watchdog_timer_driver wdt_driver( 
                                    .rstn(rstn),
                                    .clk(clk),
                                    .data_in(data_in),
                                    .intr(interrupt_to_driver),
                                    .delta(flag_from_driver)
                                );

assign interrupt_top = interrupt_to_driver;                                 

endmodule