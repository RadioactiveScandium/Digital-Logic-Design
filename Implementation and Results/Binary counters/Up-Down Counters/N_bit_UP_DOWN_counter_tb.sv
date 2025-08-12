`timescale 1ns/1ns
module counter_nbit_up_down_test #(parameter WIDTH = 3) ();

logic clk, rstn, direction;
logic [WIDTH-1:0] count_out;

counter_nbit_up_down dut (
                             .clk(clk),
                             .rstn(rstn),
                             .direction(direction),
                             .count_out(count_out)
                         );

initial begin
            clk  = 1'b0;
            rstn = 1'b1;
            direction = 1'b0;
end

initial forever #5 clk = ~clk;

initial begin
    $fsdbDumpvars("+fsdbfile+counter_nbit_up_down_test.fsdb","+all");
    rstn=1'b0; #20;
    rstn=1'b1; direction = 1'b0; #100;
    rstn=1'b1; direction = 1'b1; #100;
    rstn=1'b1; direction = 1'b0; #100;
    $finish;
end
        
endmodule