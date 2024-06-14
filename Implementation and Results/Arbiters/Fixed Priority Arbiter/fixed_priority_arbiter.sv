module fixed_priority_arbiter (
                                    input  logic [2:0] req,
                                    output logic [2:0] grant
                              );

assign  grant[0] = req[0];                             

genvar i;

for (i = 1; i<3; i++)
   assign grant[i] = req[i] & (~|grant[i-1:0]);

endmodule
