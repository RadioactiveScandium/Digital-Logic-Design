module counter_nbit_up_down_test ();
         parameter WIDTH = 3; 
         reg clock, resetn;
         wire [WIDTH-1:0] Q;

        counter_nbit_up_down dut (
                .clock(clock),
                .resetn(resetn),
                .Q(Q)
            );

        initial 
                begin
                    clock = 1'b0;
                    resetn = 1'b1;
                end

        always #5 clock = ~clock;

        initial 
                begin
                   $dumpfile("test.vcd");
                   $dumpvars(0,counter_nbit_up_down_test);
                    resetn=1'b0; #20;
                    resetn=1'b1; #300;
                    $finish;
                end
        
endmodule
