module PCCM(input clk, reset,
				input wire [3:0] pccm_ctl_con_export,	// used for NIOS to PCCM control communication
				output wire [3:0] pccm_rsp_con_export,	// used for PCCM to NIOS control communication
				output wire [10:0] pcm_mem_mm_address,
				output wire pcm_mem_mm_chipselect,
				output wire pcm_mem_mm_clken,
				output wire pcm_mem_mm_write,
				input wire  [15:0] pcm_mem_mm_readdata,
				output wire [15:0] pcm_mem_mm_writedata,
				output wire [1:0] pcm_mem_mm_byteenable);
			
			
			enum logic [3:0] {WAIT, MEM_1_0, MEM_2_0, MEM_1_1, MEM_2_1, END, ERROR} cur_state, next_state;
			logic [10:0] counter;
			
			always_ff @ (posedge clk)
			begin
				cur_state <= next_state;
				if(cur_state == WAIT)
					counter <= 11'b0;
				else if(cur_state == MEM_1_0 || cur_state == MEM_1_1)
					counter <= counter + 1'b1;
				
			end
			
			always_comb
			begin
				next_state = cur_state;
				case (cur_state)
					
					WAIT:
					begin
						if(pccm_ctl_con_export == 4'h2)
							next_state = MEM_1_0;
					end
						
					MEM_1_0:
					begin
						if(counter >= 11'b11111111111)
							next_state = END;
						else
							next_state = MEM_1_1;
					end
					
					MEM_1_1:
					begin
						if(counter >= 11'b11111111111)
							next_state = END;
						else
							next_state = MEM_1_0;
					end
					
					
					ERROR:
					begin
					end
					
					END :
					begin
						if(pccm_ctl_con_export == 4'h4)
							next_state = WAIT;
					end
					
				endcase
			end
			
			always_latch
			begin
			
				case (cur_state)
					WAIT: 
					begin
						pccm_rsp_con_export <= 4'h0;
						pcm_mem_mm_write <= 1'b0;
					end
					
					MEM_1_0:
					begin
						pccm_rsp_con_export <= 4'h2;
						pcm_mem_mm_write <= 1'b1;
						pcm_mem_mm_byteenable <= 2'b11;
						pcm_mem_mm_writedata <= 16'h0705;
					end
					
					MEM_1_1:
					begin
						pccm_rsp_con_export <= 4'h2;
						pcm_mem_mm_write <= 1'b1;
						pcm_mem_mm_byteenable <= 2'b11;
						pcm_mem_mm_writedata <= 16'h0806;
					end
					
					ERROR:
					begin
					   pccm_rsp_con_export <= 4'h8;
						pcm_mem_mm_write <= 1'b0;
					end
					
					END:
					begin
						pccm_rsp_con_export <= 4'h4;
						pcm_mem_mm_write <= 1'b0;
					end
					
				endcase
			
			end
			
			
			assign pcm_mem_mm_address = counter;
			assign pcm_mem_mm_clken = 1'b1;
			assign pcm_mem_mm_chipselect = 1'b1;
			
			endmodule
			