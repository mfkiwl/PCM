module PCCM(input clk, reset,
				input [3:0] pccm_ctl_con_export,	// used for NIOS to PCCM control communication
				output logic [3:0] pccm_rsp_con_export,	// used for PCCM to NIOS control communication
				input cpu0_sync, cpu1_sync, cpu2_sync, cpu3_sync, cpu0_halt, cpu1_halt, cpu2_halt, cpu3_halt,
				output logic int_reset, int_init, cpu0_Continue, cpu1_Continue, cpu2_Continue, cpu3_Continue);
			
			
			enum logic [3:0] {WAIT, INIT_0, INIT_1, START, RUNNING, RESET, RESETED, DONE, ERROR} cur_state, next_state;
			logic [11:0] counter;
			
			always_ff @ (posedge clk)
			begin
				cur_state <= next_state;
				if(cur_state == WAIT)
					counter <= 11'b0;
				else if(cur_state == INIT_1)
					counter <= counter + 1'b1;
				
			end
			
			always_comb
			begin
				next_state = cur_state;
				case (cur_state)
					
					WAIT:
					begin
						if(pccm_ctl_con_export == 4'h2)
							next_state = INIT_0;
					end
						
					INIT_0:
					begin
						next_state = INIT_1;
					end
					
					INIT_1:
					begin
						if(counter >= 12'h0ff)
							next_state = START;
					end
					
					START:
					begin
						next_state = RUNNING;
					end
					
					RUNNING:
					begin
						if(cpu0_halt && cpu1_halt && cpu2_halt && cpu3_halt)
							next_state = DONE;
					end
					
					
					RESET:
					begin
						next_state = RESETED;
					end
					
					
					
					RESETED :
					begin
						//next_state = WAIT;
					end
					
					DONE:
					begin
						
					end
					
				endcase
				
				if(pccm_ctl_con_export == 4'h1)
					next_state = WAIT;
					
				if(pccm_ctl_con_export == 4'h5)
					next_state = RESET;
			end
			
			always_latch
			begin
			
				case (cur_state)
					WAIT:
					begin
						pccm_rsp_con_export = 4'h1;
					end
						
					INIT_0:
					begin
						pccm_rsp_con_export = 4'h2;
						int_init = 1'b0;
					end
					
					INIT_1:
					begin
						pccm_rsp_con_export = 4'h2;
					end
					
					START:
					begin
						pccm_rsp_con_export = 4'h2;
						cpu0_Continue = 1'b1;
						cpu1_Continue = 1'b1;
						cpu2_Continue = 1'b1;
						cpu3_Continue = 1'b1;
					end
					
					RUNNING:
					begin
						pccm_rsp_con_export = 4'h2;
						cpu0_Continue = 1'b0;
						cpu1_Continue = 1'b0;
						cpu2_Continue = 1'b0;
						cpu3_Continue = 1'b0;
					end
					
					RESET:
					begin
						int_reset = 1'b1;
					end
					
					
					
					RESETED :
					begin
						pccm_rsp_con_export = 4'h5;
						int_reset = 1'b0;
					end
					
					DONE:
					begin
						pccm_rsp_con_export = 4'h3;
					end
					
				endcase
				
				if( cpu0_sync && cpu1_sync && cpu2_sync && cpu3_sync)
				begin
					cpu0_Continue = 1'b1;
					cpu1_Continue = 1'b1;
					cpu2_Continue = 1'b1;
					cpu3_Continue = 1'b1;
				end
			
			end
			
			
			endmodule
			