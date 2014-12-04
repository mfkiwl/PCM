module SOC_W_PCM(input clk, reset,
					  output [12:0] sdram_wire_addr,
					  output  [1:0] sdram_wire_ba,
					  output        sdram_wire_cas_n,
					  output		sdram_wire_cke,
					  output		sdram_wire_cs_n,
					  inout  [31:0] sdram_wire_dq,
					  output  [3:0] sdram_wire_dqm,
					  output		sdram_wire_ras_n,
					  output		sdram_wire_we_n,
					  output		sdram_wire_clk );
			

			wire        reset_reset_n;           //         reset.reset_n
			wire [3:0]  pccm_ctl_con_export;     //  pccm_ctl_con.export
			wire [3:0]  pccm_rsp_con_export;     //  pccm_rsp_con.export
			wire [10:0] pcm_mem_mm_address;      //    pcm_mem_mm.address
			wire        pcm_mem_mm_chipselect;   //              .chipselect
			wire        pcm_mem_mm_clken;        //              .clken
			wire        pcm_mem_mm_write;        //              .write
			wire [15:0] pcm_mem_mm_readdata;     //              .readdata
			wire [15:0] pcm_mem_mm_writedata;    //              .writedata
			wire [1:0]  pcm_mem_mm_byteenable;   //              .byteenable
			
			/*
			wire [12:0] sdram_wire_addr;         //    sdram_wire.addr
			wire [1:0]  sdram_wire_ba;           //              .ba
			wire        sdram_wire_cas_n;        //              .cas_n
			wire        sdram_wire_cke;          //              .cke
			wire        sdram_wire_cs_n;         //              .cs_n
			wire [31:0] sdram_wire_dq;           //              .dq
			wire [3:0]  sdram_wire_dqm;          //              .dqm
			wire        sdram_wire_ras_n;        //              .ras_n
			wire        sdram_wire_we_n;          //              .we_n
			*/
							
			nois_system nios_i(.clk_clk(clk), .reset_reset_n(reset),
									.pccm_ctl_con_export(pccm_ctl_con_export),
									.pccm_rsp_con_export(pccm_rsp_con_export),
									.pcm_mem_mm_address(pcm_mem_mm_address),
									.pcm_mem_mm_chipselect(pcm_mem_mm_chipselect),
									.pcm_mem_mm_clken(pcm_mem_mm_clken),
									.pcm_mem_mm_write(pcm_mem_mm_write),
									.pcm_mem_mm_readdata(pcm_mem_mm_readdata),
									.pcm_mem_mm_writedata(pcm_mem_mm_writedata),
									.pcm_mem_mm_byteenable(pcm_mem_mm_byteenable),
									.sdram_wire_addr(sdram_wire_addr),
									.sdram_wire_ba(sdram_wire_ba),
									.sdram_wire_cas_n(sdram_wire_cas_n),
									.sdram_wire_cke(sdram_wire_cke),
									.sdram_wire_cs_n(sdram_wire_cs_n),
									.sdram_wire_dq(sdram_wire_dq),
									.sdram_wire_dqm(sdram_wire_dqm),
									.sdram_wire_ras_n(sdram_wire_ras_n),
									.sdram_wire_we_n(sdram_wire_we_n),
									.sdram_wire_clk(sdram_wire_clk) );
			
			PCCM pccm_i(.*, .reset(~reset));
			
			logic cpu0_run cpu1_continue, cpu0_CE, cpu0_UB, cpu0_LB, cpu_OE, cpu_WE;
			
			CPU cpu0( .Clk(clk), .Reset(~reset), .Run(cpu0_run) , .Continue(cpu1_continue), .Mem_CE, Mem_UB, Mem_LB, Mem_OE, Mem_WE, output logic[11:0]LED,
				output logic[19:0]ADDR,
				inout			[15:0]Data,
				inout [15:0] index);
			
					
					
			endmodule
					