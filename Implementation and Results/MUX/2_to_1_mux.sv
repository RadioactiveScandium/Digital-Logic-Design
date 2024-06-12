module mux_2_to_1 (
    input in0, in1, sel,en,
    output reg out              // the signal out is declared as reg since this has later been used as a proecdural continuous assignment
    );
   
always_comb 
      begin     
            if(~en)
                 assign out = 1'b0;
            else 
                 assign out = sel ? in1 : in0 ;
       end
endmodule    
