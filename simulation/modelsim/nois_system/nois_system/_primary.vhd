library verilog;
use verilog.vl_types.all;
entity nois_system is
    port(
        clk_clk         : in     vl_logic;
        reset_reset_n   : in     vl_logic;
        pccm_ctl_con_export: out    vl_logic_vector(3 downto 0);
        pccm_rsp_con_export: in     vl_logic_vector(3 downto 0);
        pcm_mem_mm_address: in     vl_logic_vector(10 downto 0);
        pcm_mem_mm_chipselect: in     vl_logic;
        pcm_mem_mm_clken: in     vl_logic;
        pcm_mem_mm_write: in     vl_logic;
        pcm_mem_mm_readdata: out    vl_logic_vector(15 downto 0);
        pcm_mem_mm_writedata: in     vl_logic_vector(15 downto 0);
        pcm_mem_mm_byteenable: in     vl_logic_vector(1 downto 0);
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
end nois_system;
