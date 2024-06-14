`timescale 1ns/1ps
module fixed_priority_arbiter_test ();

logic [2:0] req;
logic [2:0] grant;

fixed_priority_arbiter fixed_priority_arbiter_inst ( .* );

initial begin
      req[0] = 1'b0;
      req[1] = 1'b0;
      req[2] = 1'b0; #15;
end

initial begin
              $dumpfile("test.vcd");
    		  $dumpvars(0,fixed_priority_arbiter_test);
              {req[0],req[1],req[2]} = {1'b0,1'b0,1'b1}; #20;   
              {req[0],req[1],req[2]} = {1'b0,1'b1,1'b0}; #20;
              {req[0],req[1],req[2]} = {1'b1,1'b0,1'b0}; #20;
              {req[0],req[1],req[2]} = {1'b1,1'b0,1'b1}; #20;
              {req[0],req[1],req[2]} = {1'b1,1'b1,1'b0}; #20;
              {req[0],req[1],req[2]} = {1'b1,1'b1,1'b1}; #77;
              $finish;
end

endmodule
