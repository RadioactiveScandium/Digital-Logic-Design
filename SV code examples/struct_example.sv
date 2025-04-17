typedef struct packed {
      logic [15:0] data_A;
      logic [15:0] data_B;
  } INFO_OP ;

INFO_OP info_OP;


module struct_design (
                        input  logic [15:0] inp_A,
                        input  logic [15:0] inp_B,
                        output logic [16:0] data_C,
                        output logic        is_eq,
                        input  logic        enable
                    );

assign info_OP.data_A = inp_A;
assign info_OP.data_B = inp_B;
assign data_C = enable ? ( info_OP.data_A + info_OP.data_B ) : 1'b0;
assign is_eq  = info_OP.data_A ^ info_OP.data_B;

endmodule