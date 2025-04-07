module watchdog_timer #(parameter MAX_COUNT=32)
                      (
                          input  logic rstn,
                          input  logic clk,
                          input  logic flag,
                          output logic interrupt
                      );

logic [$clog2(MAX_COUNT)-1:0] count_internal;

always_ff @ (posedge clk or negedge rstn) begin
    if(~rstn) begin
        interrupt <= 1'b0;
        count_internal <= 'b0;
    end
    else begin
         if(flag) begin
             if(count_internal == MAX_COUNT-1) begin
                 interrupt <= 1'b1;
                 count_internal <= 'b0;
             end
             else begin
                 //interrupt <= 1'b0;
                 interrupt <= interrupt; 
                 count_internal <= count_internal + 1;
             end
         end
         else begin
                 interrupt <= 1'b0;
                 count_internal <= 'b0;
         end
    end
end


endmodule