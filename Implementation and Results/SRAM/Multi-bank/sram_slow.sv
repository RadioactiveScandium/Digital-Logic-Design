module sram_slow #( 
                parameter int WIDTH = 16,
                parameter int DEPTH = 1024
             ) 
             ( 
                input  logic                     rstn,  
                input  logic                     clk,  
                input  logic                     sel,
                input  logic                     wren,  
                input  logic                     rden,  
                input  logic [$clog2(DEPTH)-1:0] addr,
                input  logic [WIDTH-1:0]         wr_data,
                output logic [WIDTH-1:0]         rd_data
             );

logic [DEPTH-1:0][WIDTH-1:0] sram;

always_ff@(posedge clk or negedge rstn) begin
    if(~rstn)
        {sram,rd_data} <= {0,16'h0};
    else begin
        if(sel) begin 
          case({wren,rden})
              2'b00 :   sram[addr] <= sram[addr];    // No Operation
              2'b01 :   rd_data    <= sram[addr];    // Read Operation 
              2'b10 :   sram[addr] <= wr_data;       // Write Operation
              2'b11 :   sram[addr] <= 16'h0;         // Corrupting the memory by writing all zeros if read / write is attempted at same instant on the same address
              default : sram[addr] <= sram[addr];    // No Operation
          endcase
        end
        else
              sram[addr] <= sram[addr];
    end
end

// Suggested enhancement - add an assertion which fires if SRAM data is non-zero when (rd_addr == wr_addr)

endmodule