/* 

Schematic is available at --> https://vlsitutorials.com/glitch-free-clock-mux/ 

*/

module glitchless_mux_2to1 (
                              input logic  sel,
                              input logic  rstn,
                              input logic  clk1,
                              input logic  clk2,
                              output logic outclk
                           );
                           
logic i_and1;
logic i_and2;
logic flop2_o;
logic flop1_o;
logic flop2_o_sync;
logic flop1_o_sync;

//assign i_and2 =  sel && ~flop1_o;
//assign i_and1 = ~sel && ~flop2_o;

/*
always_ff @ (posedge clk2 or negedge rstn) begin
   if(~rstn) begin
      flop2_o <= 1'b0;
      flop2_o_sync <= 1'b0;
   end
   else begin
      flop2_o <= i_and2;
      flop2_o_sync <= flop2_o;
   end
end

always_ff @ (posedge clk1 or negedge rstn) begin
   if(~rstn) begin
      flop1_o <= 1'b0;
      flop1_o_sync <= 1'b0;
   end
   else begin
      flop1_o <= i_and1;
      flop1_o_sync <= flop1_o;
   end
end
*/

//assign o_and2 = flop2_o && clk2;
//assign o_and1 = flop1_o && clk1;
//assign outclk = o_and1  ||  o_and2; 

assign i_and2 =  sel & ~flop1_o_sync;
assign i_and1 = ~sel & ~flop2_o_sync;

/* Synchronizing the select signal to either clock domains */
double_sync_cell i_sel_s2clk1 (
                                .rstn(rstn),
                                .clk(clk1),
                                .d(i_and1),
                                .o(flop1_o_sync)
                              );

double_sync_cell i_sel_s2clk2 (
                                .rstn(rstn),
                                .clk(clk2),
                                .d(i_and2),
                                .o(flop2_o_sync)
                              ); 

assign o_and2 = flop2_o_sync & clk2;
assign o_and1 = flop1_o_sync & clk1;

assign outclk = o_and1 |  o_and2; 

endmodule
