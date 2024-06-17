/*  This code has been pushed without taking it through simulation. Verify ASAP */

module round_robin_arbiter (
				input logic rstn,
				input logic clk,
				input logic [3:0] request,
				output logic [3:0] grant

			  );

enum logic [3:0] {IDLE, Grant0,Grant1,Grant2,Grant3} state,next_state;


always_ff @ (posedge clk or negedge rstn) begin : NS_TO_PS_SEQ
	if (~rstn) 
		state <= IDLE;
	else
		state <= next_state;		
end 

always_comb begin : STATE_TRANSITION_COMBO
	case(state)
		 IDLE    : next_state = (req[0] == 1'b1) ? Grant0 : IDLE;
		 Grant0  : next_state = (req[1] == 1'b1) ? Grant1 : Grant0;				
		 Grant1  : next_state = (req[2] == 1'b1) ? Grant2 : Grant1;				
		 Grant2  : next_state = (req[3] == 1'b1) ? Grant3 : Grant2;				
		 Grant3  : next_state = IDLE;
	         default : next state = IDLE;
	endcase
				
end

always_comb begin : OUTPUT_COMBO
	case (state)
		Grant0  : grant = 4'b0001;
		Grant1  : grant = 4'b0010;
		Grant2  : grant = 4'b0100;
		Grant3  : grant = 4'b1000;
		default : grant = 4'b0000;
	endcase
end

endmodule