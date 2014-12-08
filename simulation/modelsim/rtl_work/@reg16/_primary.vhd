library verilog;
use verilog.vl_types.all;
entity Reg16 is
    port(
        Clk             : in     vl_logic;
        Reset           : in     vl_logic;
        Load            : in     vl_logic;
        Din             : in     vl_logic_vector(15 downto 0);
        Dout            : out    vl_logic_vector(15 downto 0)
    );
end Reg16;
