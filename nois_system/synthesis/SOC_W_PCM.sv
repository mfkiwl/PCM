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
			
			

			logic cpu0_sync, cpu1_sync, cpu2_sync, cpu3_sync, cpu0_halt, cpu1_halt, cpu2_halt, cpu3_halt;
			logic int_reset, int_init, cpu0_Continue, cpu1_Continue, cpu2_Continue, cpu3_Continue;
			
			PCCM pccm_i(.*, .reset(~reset));
			
			logic cpu0_write;										// cpu0
		   logic [19:0] cpu0_addr;
		   logic [15:0] cpu0_data_in;
		   logic cpu0_ready;
		   logic [15:0] cpu0_data_out;
		   logic cpu1_write;										// cpu1
		   logic [19:0] cpu1_addr;
		   logic [15:0] cpu1_data_in;
		   logic cpu1_ready;
		   logic [15:0] cpu1_data_out;
		   logic cpu2_write;										// cpu2
		   logic [19:0] cpu2_addr;
		   logic [15:0] cpu2_data_in;
		   logic cpu2_ready;
		   logic [15:0] cpu2_data_out;
		   logic cpu3_write;										// cpu3
		   logic [19:0] cpu3_addr;
		   logic [15:0] cpu3_data_in;
		   logic cpu3_ready;
		   logic [15:0] cpu3_data_out;
		  

			//PCM_MM pcm_mem(.*, .init(int_init), .pcm_mem_mm_address(pcm_mem_mm_address_long));
			
			// CPU 0
			logic cpu0_run, cpu0_continue, cpu0_CE, cpu0_UB, cpu0_LB, cpu0_OE, cpu0_WE;
			logic [15:0] index0,index1,index2,index3;
			assign index0 = 16'h0000;
			wire [15:0] cpu0_data;
			
			CPU cpu0( .Clk(clk), .Reset(int_reset), .Run(cpu0_run) , .Continue(cpu0_continue), .index(index0), .Mem_CE(cpu0_CE), .Mem_UB(cpu0_UB), .Mem_LB(cpu0_LB), .Mem_OE(cpu0_OE), .Mem_WE(cpu0_write), .ADDR(cpu0_addr), .Data_in(cpu0_data_out), .mem_ready(cpu0_ready), .sync_b(cpu0_sync), .halt_b(cpu0_halt), .Data_out(cpu0_data_in));
			
			// CPU 1
			logic cpu1_run, cpu1_continue, cpu1_CE, cpu1_UB, cpu1_LB, cpu1_OE, cpu1_WE;

			assign index1 = 16'h0001;
			wire [15:0] cpu1_data;
			
			CPU cpu1( .Clk(clk), .Reset(int_reset), .Run(cpu1_run) , .Continue(cpu1_continue), .index(index1), .Mem_CE(cpu1_CE), .Mem_UB(cpu1_UB), .Mem_LB(cpu1_LB), .Mem_OE(cpu1_OE), .Mem_WE(cpu1_write), .ADDR(cpu1_addr), .Data_in(cpu1_data_out), .mem_ready(cpu1_ready), .sync_b(cpu1_sync), .halt_b(cpu1_halt), .Data_out(cpu1_data_in));
			
			// CPU 2
			logic cpu2_run, cpu2_continue, cpu2_CE, cpu2_UB, cpu2_LB, cpu2_OE, cpu2_WE;

			assign index2 = 16'h0002;
			wire [15:0] cpu2_data;
			
			CPU cpu2( .Clk(clk), .Reset(int_reset), .Run(cpu2_run) , .Continue(cpu2_continue), .index(index2), .Mem_CE(cpu2_CE), .Mem_UB(cpu2_UB), .Mem_LB(cpu2_LB), .Mem_OE(cpu2_OE), .Mem_WE(cpu2_write), .ADDR(cpu2_addr), .Data_in(cpu2_data_out), .mem_ready(cpu2_ready), .sync_b(cpu2_sync), .halt_b(cpu2_halt), .Data_out(cpu2_data_in));
			
			// CPU 3
			logic cpu3_run, cpu3_continue, cpu3_CE, cpu3_UB, cpu3_LB, cpu3_OE, cpu3_WE;

			assign index3 = 16'h0003;
			wire [15:0] cpu3_data;
			
			CPU cpu3( .Clk(clk), .Reset(int_reset), .Run(cpu3_run) , .Continue(cpu3_continue), .index(index3), .Mem_CE(cpu3_CE), .Mem_UB(cpu3_UB), .Mem_LB(cpu3_LB), .Mem_OE(cpu3_OE), .Mem_WE(cpu3_write), .ADDR(cpu3_addr), .Data_in(cpu3_data_out), .mem_ready(cpu3_ready), .sync_b(cpu3_sync), .halt_b(cpu3_halt), .Data_out(cpu3_data_in));
			
			
			
					
					
			endmodule
					