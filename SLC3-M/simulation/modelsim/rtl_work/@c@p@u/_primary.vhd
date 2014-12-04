library verilog;
use verilog.vl_types.all;
entity CPU is
    port(
        Clk             : in     vl_logic;
        Reset           : in     vl_logic;
        Run             : in     vl_logic;
        Continue        : in     vl_logic;
        ContinueIR      : in     vl_logic;
        Mem_CE          : out    vl_logic;
        Mem_UB          : out    vl_logic;
        Mem_LB          : out    vl_logic;
        Mem_OE          : out    vl_logic;
        Mem_WE          : out    vl_logic;
        LED             : out    vl_logic_vector(11 downto 0);
        ADDR            : out    vl_logic_vector(19 downto 0);
        Data            : inout  vl_logic_vector(15 downto 0);
        index           : inout  vl_logic_vector(15 downto 0)
    );
end CPU;
