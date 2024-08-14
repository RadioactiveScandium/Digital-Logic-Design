/*
8-bit sram, with 16 depth and 4 bits reserved. Below are the parameters that represent this :

DEPTH = 16 ; WIDTH = 8 ; RESERVED = 4 (MSBs) 
*/

module sram_8w_16d_4rx #(parameter WIDTH = 8, DEPTH = 16, ADDR = 16) (
                                 input logic                  clk,      
                                 input logic                  rstn,      
                                 input logic                  wren,      
                                 input logic                  rden,      
                                 input logic                  boot_mode,      
                                 input logic                  train_mode,
                                 input logic  [WIDTH-1:0]     data_in, 
                                 input logic  [ADDR-1:0]      addr,
                                 output logic [WIDTH-1:0]     data_out 
                         );

bit   [DEPTH-1:0][WIDTH-1:0]   sram;
logic [($clog2(WIDTH)+1):0]    ones_count_top;
logic [WIDTH-1:0]              data_out_ff; 
logic [WIDTH-1:0]              data_out_xor; 
logic [WIDTH-1:0]              data_out_xor_ff; 
logic count_GT_1;

always_ff @ (posedge clk or negedge rstn) begin
      if (~rstn) begin 
                data_out <= 'h0;
                sram     <= 'h0; 
      end

      else begin
            /* If not in boot mode, write to specific locations in the SRAM */
               if (boot_mode == 1'b0) begin 
                              if (wren && ~rden) begin
                              //if (wren == 1'b1 && rden == 1'b0) begin
                                       /* ENHANCEMENT : Add a feature where the user can select between
                                        generating a pattern like below or writing a custom data  */
                                          if (train_mode) begin
                                             for (integer i = 0 ; i < DEPTH ; i = i+1) begin : PATTERN_GENERATOR 
                                                   sram[i] <= i+1 ;
                                             end
                                          end
                                          else
                                             sram[addr] <= data_in;
                              end
              end

            /* If in boot mode, read from desired locations*/
              else begin
                              if (wren == 1'b0 && rden == 1'b1)
                                        data_out <= sram[addr];
              end

     end 

end

//always_ff @ (posedge clk or negedge rstn) begin
//
//      if (~rstn)
//                data_out_ff <= 'h0;
//      else  
//                data_out_ff <= data_out;
//end

CountOnes CountOnes_8w_16d_4rx (
                                 .ones_count(ones_count_top),
                                 .binary_data(data_out)
                               );

always_comb begin
   count_GT_1  = 1'b0;
   if (ones_count_top > 1)
       count_GT_1 = 1'b1;
end

always_comb begin
   data_out_xor = 0;
   if (count_GT_1) 
       data_out_xor = data_out ^ data_in ; 
end

/* Registering the XOR output to delay it by one clock cycle */
always_ff @ (posedge clk or negedge rstn) begin
      if (~rstn)
                data_out_xor_ff <= 'h0;
      else  
                data_out_xor_ff <= data_out_xor;
end

endmodule