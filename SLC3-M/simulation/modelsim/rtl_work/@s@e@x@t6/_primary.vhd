library verilog;
use verilog.vl_types.all;
entity SEXT6 is
    port(
        \In\            : in     vl_logic_vector(5 downto 0);
        \Out\           : out    vl_logic_vector(15 downto 0)
    );
end SEXT6;
