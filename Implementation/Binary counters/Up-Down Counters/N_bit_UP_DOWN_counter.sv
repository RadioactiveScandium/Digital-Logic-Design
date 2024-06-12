// include the defines.svh file during compilation to switch between the kind of counter to select

module counter_nbit_up_down #(parameter WIDTH = 3)				   (
  											input logic clock, 
  											input logic resetn,
  											output logic [WIDTH-1:0] Q 
										   );
 
    reg [WIDTH-1:0] tmp;
    always @ (posedge clock or negedge resetn)
        begin
           `ifdef COUNTER_UP
                 begin
                    if (~resetn) 
                        begin
                            tmp <= 0;
                        end
                     else
                        begin
                            tmp <= tmp + 1;
                        end
                 end 
            `else
                  begin 
                      if (~resetn) 
                        begin
                            //tmp <= ~0 ;
                          tmp <= {WIDTH{1'b1}}; // initializing tmp to all 1's
                        end
                      else
                        begin
                            tmp <= tmp - 1;
                        end
                  end
             `endif 
        end
    assign Q = tmp;
endmodule
