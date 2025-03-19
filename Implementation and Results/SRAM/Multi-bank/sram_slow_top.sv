module sram_slow_top #( 
                parameter int WIDTH = 16,
                parameter int DEPTH = 1024
             ) 
             ( 
                input  logic                     rstn,  
                input  logic                     clk,  
                input  logic                     wren,  
                input  logic                     rden,  
                input  logic [$clog2(DEPTH)-1:0] addr,
                input  logic [WIDTH-1:0]         wr_data,
                output logic [WIDTH-1:0]         rd_data
             );

logic [4:1]                 sel;
logic [WIDTH-1:0]           rd_data_tmp[4:1];

// A packed array instance port connection must either match the instance port by width directly, 
// or its width must be the port width times the number of instances in the array instance.
genvar i;
generate
     for (i=1; i<5; i = i + 1) begin
             sram_slow #(.WIDTH(16), .DEPTH(1024)) 
                          mem_i( 
                                     .rstn(rstn),
                                     .clk(clk),
                                     .sel(sel[i]),
                                     .wren(wren),
                                     .rden(rden),
                                     .rd_data(rd_data_tmp[i]),
                                     .addr({2'b00,addr[$clog2(DEPTH)-3:0]}),
                                     .wr_data(wr_data)
                                 );
     end
endgenerate

always_comb begin
    case({addr[$clog2(DEPTH)-1],addr[$clog2(DEPTH)-2]})
        2'b00 :  begin 
                    assign sel = 4'b0001; 
                    assign rd_data = rd_data_tmp[1]; 
                 end
        2'b01 :  begin 
                    assign sel = 4'b0010; 
                    assign rd_data = rd_data_tmp[2]; 
                 end
        2'b10 :  begin 
                    assign sel = 4'b0100; 
                    assign rd_data = rd_data_tmp[3]; 
                 end
        2'b11 :  begin 
                    assign sel = 4'b1000; 
                    assign rd_data = rd_data_tmp[4]; 
                 end
    endcase
end

// Suggestion : Write an assertion such that only one select signal can be high ; two or more is disallowed

endmodule