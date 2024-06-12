module mux_2_to_1_tb ();
    reg a, b, selx, enx;
    wire out;
    
   
    mux_2_to_1 mux_2_to_1 (
        .in0(a), 
        .in1(b),
        .sel(selx),
        .en(enx),
        .out(out)
        );
initial
    begin
        {a,b} = {2'b00}; {enx,selx} = {2'b00} ;#50;
        {a,b} = {2'b00}; {enx,selx} = {2'b10} ;#50;
        {a,b} = {2'b01}; {enx,selx} = {2'b10} ;#50;
        {a,b} = {2'b10}; {enx,selx} = {2'b10} ;#50;
        {a,b} = {2'b11}; {enx,selx} = {2'b10} ;#50;
        {a,b} = {2'b00}; {enx,selx} = {2'b11} ;#50;
        {a,b} = {2'b01}; {enx,selx} = {2'b11} ;#50;
        {a,b} = {2'b10}; {enx,selx} = {2'b11} ;#50;
        {a,b} = {2'b11}; {enx,selx} = {2'b11} ;#50;
end

initial

    begin
        $display("enx   a   b   selx    out");
        $display("-----------------------------------------");
        $monitor("%b    %b  %b   %b     %b",enx,a,b,selx,out);
    end
endmodule
