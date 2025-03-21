`timescale 1ns/1ps

module packer8_to16bit_test #(parameter FACTOR = 3, IN_WIDTH=8)();

logic        rstn; 
logic        clk;
logic [IN_WIDTH-1:0]  data_in;
logic [(FACTOR*IN_WIDTH)-1:0] data_out;

packerK_toNbit #(.FACTOR(3), .IN_WIDTH(8)) dut ( 
                                          .rstn(rstn), 
                                          .clk(clk),
                                          .data_in(data_in),
                                          .data_out(data_out)
                                    );

always #10 clk = ~clk;                                    

initial begin
   clk  = 1'b0;
   data_in = 8'h0; #20;
end

// compile the TB with appropriate defines to select a particular data width
initial begin
   $fsdbDumpvars("+fsdbfile+packer8_to16bit_test.fsdb","+all");
   rstn = 1'b0; #50;
   rstn = 1'b1; 
   `ifdef IN_WIDTH_EQ_8
       data_in = 8'h1A; #20; data_in = 8'h2A; #20;
       data_in = 8'h3A; #20; data_in = 8'h4A; #20;
       data_in = 8'h5A; #20; data_in = 8'h6A; #20;
       data_in = 8'h7A; #20; data_in = 8'h8A; #20;
       data_in = 8'h9A; #20; data_in = 8'hAA; #20;
       data_in = 8'hBA; #20; data_in = 8'hCA; #20;
       data_in = 8'hDA; #20; data_in = 8'hEA; #20;
       data_in = 8'hFA; #20; data_in = 8'h1B; #20;
   `endif
    
   `ifdef IN_WIDTH_EQ_16
       data_in = 16'h1A2A; #20; data_in = 16'h3A4A; #20;
       data_in = 16'h5A6A; #20; data_in = 16'h7A8A; #20;
       data_in = 16'h9AAA; #20; data_in = 16'hBACA; #20;
       data_in = 16'hDAEA; #20; data_in = 16'hFA1B; #20;
   `endif

   `ifdef IN_WIDTH_EQ_10
       data_in = 10'h2_1A; #20; data_in = 10'h2_2A; #20;
       data_in = 10'h2_3A; #20; data_in = 10'h2_4A; #20;
       data_in = 10'h2_5A; #20; data_in = 10'h2_6A; #20;
       data_in = 10'h2_7A; #20; data_in = 10'h2_8A; #20;
   `endif

   #10; 
   $finish;
end
endmodule
