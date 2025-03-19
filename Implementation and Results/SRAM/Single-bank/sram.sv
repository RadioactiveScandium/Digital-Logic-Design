module sram #( 
                parameter int WIDTH = 32,
                parameter int DEPTH = 1024
             ) 
             ( 
                input  logic                     rstn,  
                input  logic                     clk,  
                input  logic                     wren,  
                input  logic                     rden,  
                input  logic [$clog2(DEPTH)-1:0] wr_addr,
                input  logic [$clog2(DEPTH)-1:0] rd_addr,
                input  logic [WIDTH-1:0]         wr_data,
                output logic [WIDTH-1:0]         rd_data
             );

logic [DEPTH-1:0][WIDTH-1:0] sram;

always_ff@(posedge clk or negedge rstn) begin
    if(~rstn)
        {sram,rd_data} <= {0,{WIDTH{1'h0}}};
    else begin
        case({wren,rden})
            2'b00 : sram[wr_addr] <= sram[wr_addr];  // No Operation
            2'b01 : rd_data       <= sram[rd_addr];  // Write Operation 
            2'b10 : sram[wr_addr] <= wr_data;        // Read Operation
            // Corrupting the memory by writing all zeros if read / write is attempted at a single address at the same instant - no problem if the two addresses are different
            2'b11 : sram[wr_addr] <= (wr_addr == rd_addr) ? {WIDTH{1'h0}} : wr_data ;
            default : sram[wr_addr] <= sram[wr_addr];  // No Operation
        endcase
    end
end

endmodule