
module nois_system (
	clk_clk,
	reset_reset_n,
	pccm_ctl_con_export,
	pccm_rsp_con_export,
	pcm_mem_mm_address,
	pcm_mem_mm_chipselect,
	pcm_mem_mm_clken,
	pcm_mem_mm_write,
	pcm_mem_mm_readdata,
	pcm_mem_mm_writedata,
	pcm_mem_mm_byteenable,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n);	

	input		clk_clk;
	input		reset_reset_n;
	output	[3:0]	pccm_ctl_con_export;
	input	[3:0]	pccm_rsp_con_export;
	input	[10:0]	pcm_mem_mm_address;
	input		pcm_mem_mm_chipselect;
	input		pcm_mem_mm_clken;
	input		pcm_mem_mm_write;
	output	[15:0]	pcm_mem_mm_readdata;
	input	[15:0]	pcm_mem_mm_writedata;
	input	[1:0]	pcm_mem_mm_byteenable;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
endmodule
