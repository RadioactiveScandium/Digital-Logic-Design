module sram #( 
                parameter int ADDR_WIDTH = 16,
                parameter int DATA_WIDTH = 8
             ) 
             ( 
                input  logic                    rstn,  
                input  logic                    clk,  
                input  logic                    wren,  
                input  logic                    rden,  
                input  logic [ADDR_WIDTH-1:0]   addr,
                input  logic [DATA_WIDTH-1:0]   wr_data,
                output logic [DATA_WIDTH-1:0]   rd_data
             );

logic [(2**ADDR_WIDTH-1):0][DATA_WIDTH-1:0] sram;


always_ff@(posedge clk or negedge rstn) begin
    if(~rstn)
        {sram,rd_data} <= {0,{DATA_WIDTH{1'h0}}};
    else begin
        case({wren,rden})
            2'b00   : sram[addr] <= sram[addr];   // No Operation
            2'b01   : rd_data    <= sram[addr];   // Read Operation 
            2'b10   : sram[addr] <= wr_data;      // Write Operation
            2'b11   : sram[addr] <= wr_data;      // Write Operation
            default : sram[addr] <= sram[addr];   // No Operation
        endcase
    end
end

endmodule