library verilog;
use verilog.vl_types.all;
entity SEXT11 is
    port(
        \In\            : in     vl_logic_vector(10 downto 0);
        \Out\           : out    vl_logic_vector(15 downto 0)
    );
end SEXT11;
