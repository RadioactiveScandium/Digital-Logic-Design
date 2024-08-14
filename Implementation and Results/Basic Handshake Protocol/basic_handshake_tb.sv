`timescale 1ns/1ps
module basic_handshaking_test ();

logic rstn;
logic clk;
logic valid_top;
logic [3:0] data_sent_top;
logic [3:0] data_rcvd_top;

basic_handshake basic_handshake ( .* );

always #5 clk = ~clk;

initial begin
    rstn = 1'b0;
    clk = 1'b0;
    valid_top = 1'b0;
    data_sent_top = 4'b0;
end

initial begin
    $fsdbDumpvars("+fsdbfile+basic_handshaking_test.fsdb","+all");
    #10; rstn = 1'b1; #20;
         {valid_top,data_sent_top} = {1'b0,4'hA}; #10;  
         {valid_top,data_sent_top} = {1'b1,4'hB}; #10; 
         {valid_top,data_sent_top} = {1'b1,4'hC}; #10; 
         {valid_top,data_sent_top} = {1'b0,4'hD}; #10; 
         {valid_top,data_sent_top} = {1'b1,4'hE}; #10; 
    #40;$finish;
end

initial begin
   $display("*************************************************** RESULTS **********************************************");
   $display("******* Primary input to primary output is a two clock cycle long path *************");
   $monitor("Injected Data : %h\t\tTransferred Data : %h\t\tBusy : %b\t\tTop level valid : %b",data_sent_top,data_rcvd_top,basic_handshaking_test.basic_handshake.busy,valid_top);
end



endmodule
