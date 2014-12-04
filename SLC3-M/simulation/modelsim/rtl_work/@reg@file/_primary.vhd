library verilog;
use verilog.vl_types.all;
entity RegFile is
    port(
        Clk             : in     vl_logic;
        Reset           : in     vl_logic;
        Load            : in     vl_logic;
        SR1             : in     vl_logic_vector(2 downto 0);
        SR2             : in     vl_logic_vector(2 downto 0);
        DR              : in     vl_logic_vector(2 downto 0);
        Din             : in     vl_logic_vector(15 downto 0);
        SR1out          : out    vl_logic_vector(15 downto 0);
        SR2out          : out    vl_logic_vector(15 downto 0);
        index           : inout  vl_logic_vector(15 downto 0)
    );
end RegFile;
