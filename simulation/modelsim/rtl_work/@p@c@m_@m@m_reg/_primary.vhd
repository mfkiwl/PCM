library verilog;
use verilog.vl_types.all;
entity PCM_MM_reg is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        resolved        : in     vl_logic;
        cpu_write       : in     vl_logic;
        init            : in     vl_logic;
        addr            : in     vl_logic_vector(19 downto 0);
        data_in         : in     vl_logic_vector(15 downto 0);
        cpu_in          : in     vl_logic_vector(15 downto 0);
        schedule        : out    vl_logic;
        cpu_ready       : out    vl_logic;
        cpu_out         : out    vl_logic_vector(15 downto 0)
    );
end PCM_MM_reg;
