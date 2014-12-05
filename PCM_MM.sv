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
				  
				  output wire [10:0] pcm_mem_mm_address,
				  output wire pcm_mem_mm_chipselect,
				  output wire pcm_mem_mm_clken,
				  output wire pcm_mem_mm_write,
			  	  input wire  [15:0] pcm_mem_mm_readdata,
				  output wire [15:0] pcm_mem_mm_writedata,
				  output wire [1:0] pcm_mem_mm_byteenable);
				  
				  logic reg0_resolved, reg0_sched;
				  
				  PCM_MM_reg reg0(.clk(clk), .reset(reset), .resolved(reg0_resolved), .cpu_write(cpu0_write), .addr(cpu0_addr), 
										.data_in(pcm_mem_mm_readdata), .cpu_in(cpu0_data_in), .schedule(reg0_sched), .cpu_ready(cpu0_ready), 
										.cpu_out(cpu0_data_out), .init(init));
										
				  logic reg1_resolved, reg1_sched;
				  
				  PCM_MM_reg reg1(.clk(clk), .reset(reset), .resolved(reg1_resolved), .cpu_write(cpu1_write), .addr(cpu1_addr), 
										.data_in(pcm_mem_mm_readdata), .cpu_in(cpu1_data_in), .schedule(reg1_sched), .cpu_ready(cpu1_ready), 
										.cpu_out(cpu1_data_out), .init(init));
										
				  logic reg2_resolved, reg2_sched;
				  
				  PCM_MM_reg reg2(.clk(clk), .reset(reset), .resolved(reg2_resolved), .cpu_write(cpu2_write), .addr(cpu2_addr), 
										.data_in(pcm_mem_mm_readdata), .cpu_in(cpu2_data_in), .schedule(reg2_sched), .cpu_ready(cpu2_ready), 
										.cpu_out(cpu2_data_out), .init(init));
										
				  logic reg3_resolved, reg3_sched;
				  
				  PCM_MM_reg reg3(.clk(clk), .reset(reset), .resolved(reg3_resolved), .cpu_write(cpu3_write), .addr(cpu3_addr), 
										.data_in(pcm_mem_mm_readdata), .cpu_in(cpu3_data_in), .schedule(reg3_sched), .cpu_ready(cpu3_ready), 
										.cpu_out(cpu3_data_out), .init(init));
										
				  enum logic [2:0] {WAIT, OPERATION_0, OPERATION_1, RESOLVED} cur_state, next_state;
				  logic [3:0] reg0_pos, reg1_pos, reg2_pos, reg3_pos;
				  logic reg0_waiting, reg1_waiting, reg2_waiting, reg3_waiting;
				  
				  // CLOCKING
				  always_ff @ (posedge clk or posedge reset)
				  begin
						if(reset)
						begin
							cur_state <= WAIT;
							next_state <= WAIT;
						end
						cur_state <= next_state;
				  end
				  
				  //scheduleing
				  always_ff @ (posedge clk)
				  begin
						if(reg0_sched == 1'b1 && reg0_waiting ==1'b0)
						begin
							reg0_waiting <= 1'b1;
							reg0_pos <= 4'b1 + {3'b0,reg1_waiting} + {3'b0,reg2_waiting} + {3'b0,reg3_waiting}; 
						end
						
						if(reg1_sched == 1'b1 && reg1_waiting ==1'b0)
						begin
							reg1_waiting <= 1'b1;
							reg1_pos <= 4'b1 + {3'b0,reg0_waiting} + {3'b0,reg2_waiting} + {3'b0,reg3_waiting}; 
						end
						
						if(reg2_sched == 1'b1 && reg2_waiting ==1'b0)
						begin
							reg2_waiting <= 1'b1;
							reg2_pos <= 4'b1 + {3'b0,reg0_waiting} + {3'b0,reg1_waiting} + {3'b0,reg3_waiting}; 
						end
						
						if(reg3_sched == 1'b1 && reg3_waiting ==1'b0)
						begin
							reg3_waiting <= 1'b1;
							reg3_pos <= 4'b1 + {3'b0,reg0_waiting} + {3'b0,reg1_waiting} + {3'b0,reg2_waiting}; 
						end
				  end
				  
				  //transitions
				  always_comb
				  begin
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
						case(cur_state)
						WAIT:
						begin
							reg0_resolved <= 1'b0;
							reg1_resolved <= 1'b0;
							reg2_resolved <= 1'b0;
							reg3_resolved <= 1'b0;
						end
						
						OPERATION_0:
						begin
							reg0_resolved <= 1'b0;
							reg1_resolved <= 1'b0;
							reg2_resolved <= 1'b0;
							reg3_resolved <= 1'b0;
							
							if(reg0_pos == 4'b1)
							begin
								pcm_mem_mm_address <= cpu0_addr;
								cpu0_data_out <= pcm_mem_mm_readdata;
								pcm_mem_mm_writedata <= cpu0_data_in;
							end
							
							if(reg1_pos == 4'b1)
							begin
								pcm_mem_mm_address <= cpu1_addr;
								cpu1_data_out <= pcm_mem_mm_readdata;
								pcm_mem_mm_writedata <= cpu1_data_in;
							end
							
							if(reg2_pos == 4'b1)
							begin
								pcm_mem_mm_address <= cpu2_addr;
								cpu2_data_out <= pcm_mem_mm_readdata;
								pcm_mem_mm_writedata <= cpu2_data_in;
							end
							
							if(reg3_pos == 4'b1)
							begin
								pcm_mem_mm_address <= cpu3_addr;
								cpu3_data_out <= pcm_mem_mm_readdata;
								pcm_mem_mm_writedata <= cpu3_data_in;
							end
							
						end
						
						OPERATION_1:
						begin
							reg0_resolved <= 1'b0;
							reg1_resolved <= 1'b0;
							reg2_resolved <= 1'b0;
							reg3_resolved <= 1'b0;
							
							if(reg0_pos == 4'b1)
							begin
								pcm_mem_mm_address <= cpu0_addr;
								cpu0_data_out <= pcm_mem_mm_readdata;
								pcm_mem_mm_writedata <= cpu0_data_in;
								pcm_mem_mm_write <= cpu0_write;
							end
							
							if(reg1_pos == 4'b1)
							begin
								pcm_mem_mm_address <= cpu1_addr;
								cpu1_data_out <= pcm_mem_mm_readdata;
								pcm_mem_mm_writedata <= cpu1_data_in;
								pcm_mem_mm_write <= cpu1_write;
							end
							
							if(reg2_pos == 4'b1)
							begin
								pcm_mem_mm_address <= cpu2_addr;
								cpu2_data_out <= pcm_mem_mm_readdata;
								pcm_mem_mm_writedata <= cpu2_data_in;
								pcm_mem_mm_write <= cpu2_write;
							end
							
							if(reg3_pos == 4'b1)
							begin
								pcm_mem_mm_address <= cpu3_addr;
								cpu3_data_out <= pcm_mem_mm_readdata;
								pcm_mem_mm_writedata <= cpu3_data_in;
								pcm_mem_mm_write <= cpu3_write;
							end
							
						end
						
						RESOLVED:
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
							
							reg0_resolved <= ~(reg0[3:3] | reg0[2:2] | reg0[1:1] | reg0[0:0]);
							reg0_waiting <= (reg0[3:3] | reg0[2:2] | reg0[1:1] | reg0[0:0]);
							
							reg1_resolved <= ~(reg1[3:3] | reg1[2:2] | reg1[1:1] | reg1[0:0]);
							reg1_waiting <= (reg1[3:3] | reg1[2:2] | reg1[1:1] | reg1[0:0]);
							
							reg2_resolved <= ~(reg2[3:3] | reg2[2:2] | reg2[1:1] | reg2[0:0]);
							reg2_waiting <= (reg2[3:3] | reg2[2:2] | reg2[1:1] | reg2[0:0]);
							
							reg3_resolved <= ~(reg3[3:3] | reg3[2:2] | reg3[1:1] | reg3[0:0]);
							reg3_waiting <= (reg3[3:3] | reg3[2:2] | reg3[1:1] | reg3[0:0]);
						end
						
						endcase
				  
				  end
				  
				  assign pcm_mem_mm_chipselect = 1'b1;
				  assign pcm_mem_mm_byteenable = 2'b11;
				  
				  endmodule
				  