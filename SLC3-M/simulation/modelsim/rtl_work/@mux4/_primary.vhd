library verilog;
use verilog.vl_types.all;
entity Mux4 is
    port(
        Sel             : in     vl_logic_vector(1 downto 0);
        Din0            : in     vl_logic_vector(15 downto 0);
        Din1            : in     vl_logic_vector(15 downto 0);
        Din2            : in     vl_logic_vector(15 downto 0);
        Din3            : in     vl_logic_vector(15 downto 0);
        Dout            : out    vl_logic_vector(15 downto 0)
    );
end Mux4;
