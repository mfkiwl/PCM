library verilog;
use verilog.vl_types.all;
entity Mem2IO is
    port(
        Clk             : in     vl_logic;
        Reset           : in     vl_logic;
        A               : in     vl_logic_vector(19 downto 0);
        CE              : in     vl_logic;
        UB              : in     vl_logic;
        LB              : in     vl_logic;
        OE              : in     vl_logic;
        WE              : in     vl_logic;
        Switches        : in     vl_logic_vector(15 downto 0);
        Data_CPU        : inout  vl_logic_vector(15 downto 0);
        Data_Mem        : inout  vl_logic_vector(15 downto 0);
        HEX0            : out    vl_logic_vector(3 downto 0);
        HEX1            : out    vl_logic_vector(3 downto 0);
        HEX2            : out    vl_logic_vector(3 downto 0);
        HEX3            : out    vl_logic_vector(3 downto 0)
    );
end Mem2IO;
