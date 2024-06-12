module mux_4_to_1 (
    input in0,in1,in2,in3,sel0,sel1,en_m,
    output out
    );

    logic w1,w2;

mux_2_to_1 mux_2_to_1_U1 (
            .in0(in0),
            .in1(in1),
            .sel(sel0),
            .en(en_m),
            .out(w1)
            ); 

mux_2_to_1 mux_2_to_1_U2 (
            .in0(in2),
            .in1(in3),
            .sel(sel1),
            .en(~en_m),
            .out(w2)
            );

assign out = w1 | w2 ;

endmodule
