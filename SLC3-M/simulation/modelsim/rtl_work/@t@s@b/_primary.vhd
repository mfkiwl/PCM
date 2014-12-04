library verilog;
use verilog.vl_types.all;
entity TSB is
    port(
        Switch          : in     vl_logic;
        Din             : in     vl_logic_vector(15 downto 0);
        Dout            : out    vl_logic_vector(15 downto 0)
    );
end TSB;
