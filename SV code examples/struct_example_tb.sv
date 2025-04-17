`timescale 1ns/1ps
module struct_tb ();

logic [15:0] inpA;
logic [15:0] inpB;
logic [16:0] data_C;
logic        is_eq;
logic        enable;

struct_design dut (
                      .inp_A(inpA),
                      .inp_B(inpB),
                      .data_C(data_C),
                      .is_eq(is_eq),
                      .enable(enable)
                    );

initial begin
    enable = 1'b1;  inpA = 16'h0000; inpB = 16'h0000;
    #100;
    inpA = 16'h0001; inpB = 16'h0002;
    #100;
    inpA = 16'h000C; inpB = 16'h000C;
    #20;
end

initial begin
    $monitor("%d\t\t%d\t\t%d\t\t%b",inpA,inpB,data_C,is_eq);
end

endmodule