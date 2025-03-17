`timescale 1ns/1ps
module pipeline_flops_test #(parameter NUM_STAGES=3,DATA_WIDTH=16) ();

logic rstn, clk;
logic [DATA_WIDTH-1:0] inp, out_top;

pipeline_flops #(.NUM_STAGES(2)) 
            dut( 
                  .rstn(rstn),
                  .clk(clk),
                  .inp(inp),
                  .out_top(out_top)
               );

always #5 clk = ~clk;

initial begin
    rstn = 1'b0;
    clk = 1'b0;
    inp = 1'b0; #20;
end

initial begin
    $fsdbDumpvars("+fsdbfile+top_test.fsdb","+all");
    #20;
    rstn = 1'b1;#50;
    inp = 1'b1; #50;
    inp = 1'b0; #50;
    inp = 1'b1; #50;
    $finish;
end

endmodule