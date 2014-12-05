library verilog;
use verilog.vl_types.all;
entity NZPreg is
    port(
        Clk             : in     vl_logic;
        Reset           : in     vl_logic;
        Load            : in     vl_logic;
        LastResult      : in     vl_logic_vector(15 downto 0);
        NZP             : out    vl_logic_vector(2 downto 0)
    );
end NZPreg;
