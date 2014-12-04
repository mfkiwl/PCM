library verilog;
use verilog.vl_types.all;
entity SLC is
    port(
        Clk             : in     vl_logic;
        Reset           : in     vl_logic;
        Run             : in     vl_logic;
        Continue        : in     vl_logic;
        ContinueIR      : in     vl_logic;
        S               : in     vl_logic_vector(15 downto 0);
        CE              : out    vl_logic;
        UB              : out    vl_logic;
        LB              : out    vl_logic;
        OE              : out    vl_logic;
        WE              : out    vl_logic;
        A               : out    vl_logic_vector(19 downto 0);
        LED             : out    vl_logic_vector(11 downto 0);
        DIS3            : out    vl_logic_vector(6 downto 0);
        DIS2            : out    vl_logic_vector(6 downto 0);
        DIS1            : out    vl_logic_vector(6 downto 0);
        DIS0            : out    vl_logic_vector(6 downto 0);
        Data            : inout  vl_logic_vector(15 downto 0);
        index           : inout  vl_logic_vector(15 downto 0)
    );
end SLC;
