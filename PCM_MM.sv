module PCM_MM(input clk, reset, init,
				  input cpu0_write,										// cpu0
				  input [19:0] cpu0_addr,
				  input [15:0] cpu0_data_in,
				  output logic cpu0_ready,
				  output logic [15:0] cpu0_data_out,
				  input cpu1_write,										// cpu1
				  input [19:0] cpu1_addr,
				  input [15:0] cpu1_data_in,
				  output logic cpu1_ready,
				  output logic [15:0] cpu1_data_out,
				  input cpu2_write,										// cpu2
				  input [19:0] cpu2_addr,
				  input [15:0] cpu2_data_in,
				  output logic cpu2_ready,
				  output logic [15:0] cpu2_data_out,
				  input cpu3_write,										// cpu3
				  input [19:0] cpu3_addr,
				  input [15:0] cpu3_data_in,
				  output logic cpu3_ready,
				  output logic [15:0] cpu3_data_out,
				  
				  output logic [10:0] pcm_mem_mm_address,
				  output logic pcm_mem_mm_chipselect,
				  output logic pcm_mem_mm_clken,
				  output logic pcm_mem_mm_write,
			  	  input logic  [15:0] pcm_mem_mm_readdata,
				  output logic [15:0] pcm_mem_mm_writedata,
				  output logic [1:0] pcm_mem_mm_byteenable);
				  
				  logic reg0_resolved, reg0_resolved_next, reg0_sched;
				  
				  PCM_MM_reg reg0(.clk(clk), .reset(reset), .resolved(reg0_resolved), .cpu_write(~cpu0_write), .addr(cpu0_addr), 
										.data_in(pcm_mem_mm_readdata), .cpu_in(cpu0_data_in), .schedule(reg0_sched), .cpu_ready(cpu0_ready), 
										.cpu_out(cpu0_data_out), .init(init));
										
				  logic reg1_resolved, reg1_resolved_next, reg1_sched;
				  
				  PCM_MM_reg reg1(.clk(clk), .reset(reset), .resolved(reg1_resolved), .cpu_write(~cpu1_write), .addr(cpu1_addr), 
										.data_in(pcm_mem_mm_readdata), .cpu_in(cpu1_data_in), .schedule(reg1_sched), .cpu_ready(cpu1_ready), 
										.cpu_out(cpu1_data_out), .init(init));
										
				  logic reg2_resolved, reg2_resolved_next, reg2_sched;
				  
				  PCM_MM_reg reg2(.clk(clk), .reset(reset), .resolved(reg2_resolved), .cpu_write(~cpu2_write), .addr(cpu2_addr), 
										.data_in(pcm_mem_mm_readdata), .cpu_in(cpu2_data_in), .schedule(reg2_sched), .cpu_ready(cpu2_ready), 
										.cpu_out(cpu2_data_out), .init(init));
										
				  logic reg3_resolved, reg3_resolved_next, reg3_sched;
				  
				  PCM_MM_reg reg3(.clk(clk), .reset(reset), .resolved(reg3_resolved), .cpu_write(~cpu3_write), .addr(cpu3_addr), 
										.data_in(pcm_mem_mm_readdata), .cpu_in(cpu3_data_in), .schedule(reg3_sched), .cpu_ready(cpu3_ready), 
										.cpu_out(cpu3_data_out), .init(init));
										
				  enum logic [2:0] {WAIT, OPERATION_0, OPERATION_1, RESOLVED} cur_state, next_state;
				  
				  logic [3:0] reg0_pos, reg1_pos, reg2_pos, reg3_pos;
				  logic reg0_waiting, reg1_waiting, reg2_waiting, reg3_waiting, reg0_waiting_next, reg1_waiting_next, reg2_waiting_next, reg3_waiting_next;
				  
				  // CLOCKING
				  always_ff @ (posedge clk or posedge reset)
				  begin
						if(reset)
						begin
							cur_state <= WAIT;
						end
						else
						begin
							cur_state <= next_state;
						end
				  end
				  
				  //scheduleing
				  always_ff @ (posedge clk or posedge init)
				  begin
						if(init)
						begin
							reg0_pos = 4'h0;
							reg1_pos = 4'h0;
							reg2_pos = 4'h0;
							reg3_pos = 4'h0;
							
							reg0_resolved = 1'b0;
							reg0_waiting = 1'b0 ;
							
							reg1_resolved = 1'b0;
							reg1_waiting = 1'b0;
							
							reg2_resolved = 1'b0;
							reg2_waiting = 1'b0;
							
							reg3_resolved = 1'b0;
							reg3_waiting = 1'b0;
						end
						else
						begin
							if(reg0_sched == 1'b1 && reg0_waiting == 1'b0)
							begin
								reg0_waiting = 1'b1;
								reg0_pos = 4'b1 + {3'b0,reg1_waiting} + {3'b0,reg2_waiting} + {3'b0,reg3_waiting}; 
							end
							
							if(reg1_sched == 1'b1 && reg1_waiting == 1'b0)
							begin
								reg1_waiting = 1'b1;
								reg1_pos = 4'b1 + {3'b0,reg0_waiting} + {3'b0,reg2_waiting} + {3'b0,reg3_waiting}; 
							end
							
							if(reg2_sched == 1'b1 && reg2_waiting == 1'b0)
							begin
								reg2_waiting = 1'b1;
								reg2_pos = 4'b1 + {3'b0,reg0_waiting} + {3'b0,reg1_waiting} + {3'b0,reg3_waiting}; 
							end
							
							if(reg3_sched == 1'b1 && reg3_waiting == 1'b0)
							begin
								reg3_waiting = 1'b1;
								reg3_pos = 4'b1 + {3'b0,reg0_waiting} + {3'b0,reg1_waiting} + {3'b0,reg2_waiting}; 
							end
							if(cur_state == OPERATION_0)
							begin
							
								if(reg0_pos != 0)
								begin
									reg0_pos--;
								end
								
								if(reg1_pos != 0)
								begin
									reg1_pos--;
								end
								
								if(reg2_pos != 0)
								begin
									reg2_pos--;
								end
								
								if(reg3_pos != 0)
								begin
									reg3_pos--;
								end
								
							end
							
							if(cur_state == OPERATION_1 || cur_state == WAIT) // || RESOLVED
							begin
								reg0_resolved = reg0_resolved_next;
								reg0_waiting = reg0_waiting_next ;
								
								reg1_resolved = reg1_resolved_next;
								reg1_waiting = reg1_waiting_next;
								
								reg2_resolved = reg2_resolved_next;
								reg2_waiting = reg2_waiting_next;
								
								reg3_resolved = reg3_resolved_next;
								reg3_waiting = reg3_waiting_next;
							end
							
						end
				  end
				  
				  //transitions
				  always_comb
				  begin
						next_state <= cur_state;
					
						case(cur_state)
						
							WAIT:
							begin
								if(reg0_waiting != 0 || reg1_waiting != 0 || reg2_waiting != 0 || reg3_waiting != 0)
								begin
									next_state <= OPERATION_0;
								end
							end
							
							OPERATION_0:
								next_state <= OPERATION_1;
								
							OPERATION_1:
								next_state <= RESOLVED;
							
							RESOLVED:
							begin
								next_state <= WAIT;
							end
							
						endcase
				  end
				  
				  //outputs
				  always_latch
				  begin
						if(init)
						begin
							reg0_resolved_next <= 1'b0;
							reg0_waiting_next <= 1'b0;
							
							reg1_resolved_next <= 1'b0;
							reg1_waiting_next <= 1'b0;
							
							reg2_resolved_next <= 1'b0;
							reg2_waiting_next <= 1'b0;
							
							reg3_resolved_next <= 1'b0;
							reg3_waiting_next <= 1'b0;
						end
						else
						begin
							case(cur_state)
							WAIT:
							begin
								reg0_resolved_next <= 1'b0;
								reg1_resolved_next <= 1'b0;
								reg2_resolved_next <= 1'b0;
								reg3_resolved_next <= 1'b0;
							end
							
							OPERATION_0:
							begin
								reg0_resolved_next <= 1'b0;
								reg1_resolved_next <= 1'b0;
								reg2_resolved_next <= 1'b0;
								reg3_resolved_next <= 1'b0;
								
								if(reg0_pos == 4'b1)
								begin
									pcm_mem_mm_address <= cpu0_addr[10:0];
									pcm_mem_mm_writedata <= cpu0_data_in;
								end
								
								if(reg1_pos == 4'b1)
								begin
									pcm_mem_mm_address <= cpu1_addr[10:0];
									pcm_mem_mm_writedata <= cpu1_data_in;
								end
								
								if(reg2_pos == 4'b1)
								begin
									pcm_mem_mm_address <= cpu2_addr[10:0];
									pcm_mem_mm_writedata <= cpu2_data_in;
								end
								
								if(reg3_pos == 4'b1)
								begin
									pcm_mem_mm_address <= cpu3_addr[10:0];
									pcm_mem_mm_writedata <= cpu3_data_in;
								end
								
							end
							
							OPERATION_1:
							begin
								
								if(reg0_pos == 4'b1)
								begin
									pcm_mem_mm_address <= cpu0_addr[10:0];
									pcm_mem_mm_writedata <= cpu0_data_in;
									pcm_mem_mm_write <= ~cpu0_write;
								end
								
								if(reg1_pos == 4'b1)
								begin
									pcm_mem_mm_address <= cpu1_addr[10:0];
									pcm_mem_mm_writedata <= cpu1_data_in;
									pcm_mem_mm_write <= ~cpu1_write;
								end
								
								if(reg2_pos == 4'b1)
								begin
									pcm_mem_mm_address <= cpu2_addr[10:0];
									pcm_mem_mm_writedata <= cpu2_data_in;
									pcm_mem_mm_write <= ~cpu2_write;
								end
								
								if(reg3_pos == 4'b1)
								begin
									pcm_mem_mm_address <= cpu3_addr[10:0];
									pcm_mem_mm_writedata <= cpu3_data_in;
									pcm_mem_mm_write <= ~cpu3_write;
								end
								
								reg0_resolved_next <= ~(reg0_pos[3:3] | reg0_pos[2:2] | reg0_pos[1:1] | reg0_pos[0:0]) & reg0_waiting;
								reg1_resolved_next <= ~(reg1_pos[3:3] | reg1_pos[2:2] | reg1_pos[1:1] | reg1_pos[0:0]) & reg1_waiting;
								reg2_resolved_next <= ~(reg2_pos[3:3] | reg2_pos[2:2] | reg2_pos[1:1] | reg2_pos[0:0]) & reg2_waiting;
								reg3_resolved_next <= ~(reg3_pos[3:3] | reg3_pos[2:2] | reg3_pos[1:1] | reg3_pos[0:0]) & reg3_waiting;
								
							end
							
							RESOLVED:
							begin
								reg0_resolved_next <= ~(reg0_pos[3:3] | reg0_pos[2:2] | reg0_pos[1:1] | reg0_pos[0:0]) & reg0_waiting;
								reg1_resolved_next <= ~(reg1_pos[3:3] | reg1_pos[2:2] | reg1_pos[1:1] | reg1_pos[0:0]) & reg1_waiting;
								reg2_resolved_next <= ~(reg2_pos[3:3] | reg2_pos[2:2] | reg2_pos[1:1] | reg2_pos[0:0]) & reg2_waiting;
								reg3_resolved_next <= ~(reg3_pos[3:3] | reg3_pos[2:2] | reg3_pos[1:1] | reg3_pos[0:0]) & reg3_waiting;
							end
							
							endcase
							
							reg0_waiting_next <= (reg0_pos[3:3] | reg0_pos[2:2] | reg0_pos[1:1] | reg0_pos[0:0]);
							reg1_waiting_next <= (reg1_pos[3:3] | reg1_pos[2:2] | reg1_pos[1:1] | reg1_pos[0:0]);
							reg2_waiting_next <= (reg2_pos[3:3] | reg2_pos[2:2] | reg2_pos[1:1] | reg2_pos[0:0]);
							reg3_waiting_next <= (reg3_pos[3:3] | reg3_pos[2:2] | reg3_pos[1:1] | reg3_pos[0:0]);
						end
				  end
				  
				  assign pcm_mem_mm_chipselect = 1'b1;
				  assign pcm_mem_mm_byteenable = 2'b11;
				  assign pcm_mem_mm_clken = 1'b1;
				  
				  endmodule
				  