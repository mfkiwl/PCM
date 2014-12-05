library verilog;
use verilog.vl_types.all;
entity nois_system_sdram_clk_stdsync_sv6 is
    port(
        clk             : in     vl_logic;
        din             : in     vl_logic;
        dout            : out    vl_logic;
        reset_n         : in     vl_logic
    );
end nois_system_sdram_clk_stdsync_sv6;
