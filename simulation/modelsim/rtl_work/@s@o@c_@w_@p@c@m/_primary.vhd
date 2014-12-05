library verilog;
use verilog.vl_types.all;
entity SOC_W_PCM is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        sdram_wire_addr : out    vl_logic_vector(12 downto 0);
        sdram_wire_ba   : out    vl_logic_vector(1 downto 0);
        sdram_wire_cas_n: out    vl_logic;
        sdram_wire_cke  : out    vl_logic;
        sdram_wire_cs_n : out    vl_logic;
        sdram_wire_dq   : inout  vl_logic_vector(31 downto 0);
        sdram_wire_dqm  : out    vl_logic_vector(3 downto 0);
        sdram_wire_ras_n: out    vl_logic;
        sdram_wire_we_n : out    vl_logic;
        sdram_wire_clk  : out    vl_logic
    );
end SOC_W_PCM;
