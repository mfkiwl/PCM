library verilog;
use verilog.vl_types.all;
entity RegAddrMux is
    port(
        IR              : in     vl_logic_vector(15 downto 0);
        DR              : out    vl_logic_vector(2 downto 0);
        SR1             : out    vl_logic_vector(2 downto 0);
        SR2             : out    vl_logic_vector(2 downto 0)
    );
end RegAddrMux;
