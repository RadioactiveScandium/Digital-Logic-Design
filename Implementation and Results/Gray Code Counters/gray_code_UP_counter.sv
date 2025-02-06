module gray_code_UP_counter  # (parameter MOD_VALUE = 8) (                                          
                                                               input  logic clk,
                                                               input  logic rstn,
                                                               output logic [$clog2(MOD_VALUE)-1:0] gray_count_out  
                          	                             );

logic [$clog2(MOD_VALUE)-1:0] count_binary;

// Module definition stationed under Binary counters folder
N_bit_UP_counter  #(.MOD_VALUE(8))    bin_counter (                                          
                                                     .clk(clk),
                                                     .rstn(rstn),
                                                     .out(count_binary)  
                          	                       );

assign gray_count_out[$clog2(MOD_VALUE)-1] = count_binary[$clog2(MOD_VALUE)-1] ;

generate 
 for (genvar i = 0 ; i < $clog2(MOD_VALUE)-1 ; i = i + 1)
     assign gray_count_out[i] = count_binary[i] ^ count_binary[i+1];
endgenerate

endmodule