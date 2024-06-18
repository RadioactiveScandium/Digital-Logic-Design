/* Count the number of 1's and 0's in an input binary data */
module CountOnes_and_Zeros #(parameter WIDTH = 8, MAX_POSSIBLE_COUNT = ($clog2(WIDTH)+1)) (
                              input  logic [WIDTH-1:0]            binary_data,                                                                             
                              output logic [MAX_POSSIBLE_COUNT:0]  ones_count,
                              output logic [MAX_POSSIBLE_COUNT:0]  zeros_count
                            );

always_comb begin
  ones_count = 0;
  for (int i = 0; i < 8; i = i + 1) begin : ONE_COUNTER
    if (binary_data[i] == 1'b1) begin
      ones_count = ones_count + 1;
    end
  end
end

assign zeros_count = WIDTH - ones_count;
  
endmodule
