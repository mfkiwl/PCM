	nois_system u0 (
		.clk_clk               (<connected-to-clk_clk>),               //          clk.clk
		.reset_reset_n         (<connected-to-reset_reset_n>),         //        reset.reset_n
		.pccm_ctl_con_export   (<connected-to-pccm_ctl_con_export>),   // pccm_ctl_con.export
		.pccm_rsp_con_export   (<connected-to-pccm_rsp_con_export>),   // pccm_rsp_con.export
		.pcm_mem_mm_address    (<connected-to-pcm_mem_mm_address>),    //   pcm_mem_mm.address
		.pcm_mem_mm_chipselect (<connected-to-pcm_mem_mm_chipselect>), //             .chipselect
		.pcm_mem_mm_clken      (<connected-to-pcm_mem_mm_clken>),      //             .clken
		.pcm_mem_mm_write      (<connected-to-pcm_mem_mm_write>),      //             .write
		.pcm_mem_mm_readdata   (<connected-to-pcm_mem_mm_readdata>),   //             .readdata
		.pcm_mem_mm_writedata  (<connected-to-pcm_mem_mm_writedata>),  //             .writedata
		.pcm_mem_mm_byteenable (<connected-to-pcm_mem_mm_byteenable>), //             .byteenable
		.sdram_wire_addr       (<connected-to-sdram_wire_addr>),       //   sdram_wire.addr
		.sdram_wire_ba         (<connected-to-sdram_wire_ba>),         //             .ba
		.sdram_wire_cas_n      (<connected-to-sdram_wire_cas_n>),      //             .cas_n
		.sdram_wire_cke        (<connected-to-sdram_wire_cke>),        //             .cke
		.sdram_wire_cs_n       (<connected-to-sdram_wire_cs_n>),       //             .cs_n
		.sdram_wire_dq         (<connected-to-sdram_wire_dq>),         //             .dq
		.sdram_wire_dqm        (<connected-to-sdram_wire_dqm>),        //             .dqm
		.sdram_wire_ras_n      (<connected-to-sdram_wire_ras_n>),      //             .ras_n
		.sdram_wire_we_n       (<connected-to-sdram_wire_we_n>)        //             .we_n
	);

