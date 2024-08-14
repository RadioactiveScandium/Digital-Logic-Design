`timescale 1ns/1ps
module overlap_1010_test();

logic clk;
logic rstn;
logic in;
logic out;

overlap_1010 FSM_inst(
                                 .clk(clk),
                                 .rstn(rstn),
                                 .in(in),
                                 .out(out)
                         );
initial begin
   rstn = 1'b0;
   clk  = 1'b0;   
   in   = 1'b0; #10;
end

always #2 clk = ~clk;
  
initial begin
  #2 rstn = 1;
  for (integer j = 0 ; j < 27 ; j++) begin
    #3 in = $urandom_range (0,1);
  end
  #2 rstn = 1'b0;#2;
  $finish;
end

typedef enum {MEALY,MOORE} fsm_type;
  initial begin
      fsm_type type_fsm;
      `ifdef MEALY_MACHINE
    		type_fsm = MEALY;
      `else
        	type_fsm = MOORE;
      `endif
    $display("*****************");
    $display("\nFSM type : %s\n",type_fsm.name);
    $display("*****************");
end
  
initial begin
  $dumpfile("test.vcd");
  $dumpvars(0,overlap_1010_test);
end
endmodule