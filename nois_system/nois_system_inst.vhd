	component nois_system is
		port (
			clk_clk               : in    std_logic                     := 'X';             -- clk
			reset_reset_n         : in    std_logic                     := 'X';             -- reset_n
			pccm_ctl_con_export   : out   std_logic_vector(3 downto 0);                     -- export
			pccm_rsp_con_export   : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			pcm_mem_mm_address    : in    std_logic_vector(10 downto 0) := (others => 'X'); -- address
			pcm_mem_mm_chipselect : in    std_logic                     := 'X';             -- chipselect
			pcm_mem_mm_clken      : in    std_logic                     := 'X';             -- clken
			pcm_mem_mm_write      : in    std_logic                     := 'X';             -- write
			pcm_mem_mm_readdata   : out   std_logic_vector(15 downto 0);                    -- readdata
			pcm_mem_mm_writedata  : in    std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			pcm_mem_mm_byteenable : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
			sdram_wire_addr       : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_wire_ba         : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n      : out   std_logic;                                        -- cas_n
			sdram_wire_cke        : out   std_logic;                                        -- cke
			sdram_wire_cs_n       : out   std_logic;                                        -- cs_n
			sdram_wire_dq         : inout std_logic_vector(31 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm        : out   std_logic_vector(3 downto 0);                     -- dqm
			sdram_wire_ras_n      : out   std_logic;                                        -- ras_n
			sdram_wire_we_n       : out   std_logic                                         -- we_n
		);
	end component nois_system;

	u0 : component nois_system
		port map (
			clk_clk               => CONNECTED_TO_clk_clk,               --          clk.clk
			reset_reset_n         => CONNECTED_TO_reset_reset_n,         --        reset.reset_n
			pccm_ctl_con_export   => CONNECTED_TO_pccm_ctl_con_export,   -- pccm_ctl_con.export
			pccm_rsp_con_export   => CONNECTED_TO_pccm_rsp_con_export,   -- pccm_rsp_con.export
			pcm_mem_mm_address    => CONNECTED_TO_pcm_mem_mm_address,    --   pcm_mem_mm.address
			pcm_mem_mm_chipselect => CONNECTED_TO_pcm_mem_mm_chipselect, --             .chipselect
			pcm_mem_mm_clken      => CONNECTED_TO_pcm_mem_mm_clken,      --             .clken
			pcm_mem_mm_write      => CONNECTED_TO_pcm_mem_mm_write,      --             .write
			pcm_mem_mm_readdata   => CONNECTED_TO_pcm_mem_mm_readdata,   --             .readdata
			pcm_mem_mm_writedata  => CONNECTED_TO_pcm_mem_mm_writedata,  --             .writedata
			pcm_mem_mm_byteenable => CONNECTED_TO_pcm_mem_mm_byteenable, --             .byteenable
			sdram_wire_addr       => CONNECTED_TO_sdram_wire_addr,       --   sdram_wire.addr
			sdram_wire_ba         => CONNECTED_TO_sdram_wire_ba,         --             .ba
			sdram_wire_cas_n      => CONNECTED_TO_sdram_wire_cas_n,      --             .cas_n
			sdram_wire_cke        => CONNECTED_TO_sdram_wire_cke,        --             .cke
			sdram_wire_cs_n       => CONNECTED_TO_sdram_wire_cs_n,       --             .cs_n
			sdram_wire_dq         => CONNECTED_TO_sdram_wire_dq,         --             .dq
			sdram_wire_dqm        => CONNECTED_TO_sdram_wire_dqm,        --             .dqm
			sdram_wire_ras_n      => CONNECTED_TO_sdram_wire_ras_n,      --             .ras_n
			sdram_wire_we_n       => CONNECTED_TO_sdram_wire_we_n        --             .we_n
		);

