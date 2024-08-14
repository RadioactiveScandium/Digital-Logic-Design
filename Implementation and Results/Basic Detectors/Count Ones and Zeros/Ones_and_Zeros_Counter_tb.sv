module CountOnes_tb#(parameter WIDTH = 8, MAX_POSSIBLE_COUNT = ($clog2(WIDTH)+1))();
  
logic  [WIDTH-1:0]             binary_data;           
logic  [MAX_POSSIBLE_COUNT:0]  ones_count;
logic  [MAX_POSSIBLE_COUNT:0]  zeros_count;
  
CountOnes_and_Zeros Count_bits_uut ( .* );
  
initial begin
  binary_data = 8'b0; #20;
end
  
initial begin
  binary_data = 8'b00000010; #10;
  binary_data = 8'b00000110; #10;
  binary_data = 8'b00101110; #10;
  binary_data = 8'b11110010; #10;
end
  
initial begin  
  $display("Input Data \t\t Number of ones \t\t Number of zeros`");
  $monitor("%b \t\t %d \t\t\t\t %d",binary_data,ones_count,zeros_count);
end
  
endmodule