library verilog;
use verilog.vl_types.all;
entity SEXT9 is
    port(
        \In\            : in     vl_logic_vector(8 downto 0);
        \Out\           : out    vl_logic_vector(15 downto 0)
    );
end SEXT9;
