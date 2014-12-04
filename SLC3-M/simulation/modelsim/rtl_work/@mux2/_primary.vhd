library verilog;
use verilog.vl_types.all;
entity Mux2 is
    port(
        Sel             : in     vl_logic;
        Din0            : in     vl_logic_vector(15 downto 0);
        Din1            : in     vl_logic_vector(15 downto 0);
        Dout            : out    vl_logic_vector(15 downto 0)
    );
end Mux2;
