package bt_top;

parameter int ADDR_WIDTH = 8;
parameter int ADDR_MAX   = 2**ADDR_WIDTH -1 ;
parameter int BURST_LEN  = 15;
parameter int DATA_WIDTH = 8;

endpackage


package addr_mod;

parameter int STRIDE_LEN = 8 ;

endpackage //addr_mod


package sram_pkg;

parameter int ADDR_WIDTH = 8;
parameter int DATA_WIDTH = 8;

endpackage //sram_pkg