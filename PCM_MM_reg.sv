module PCM_MM_reg(input logic clk, reset, resolved, cpu_write, init,
						input logic [19:0] addr,
						input logic [15:0] data_in, cpu_in,
						output logic schedule, cpu_ready,
						output logic [15:0] cpu_out);
						
						enum logic [1:0] {WAIT, CONFLICT} cur_state, next_state;
						
						logic [19:0] addr_reg;
						
						always_ff @ (posedge clk or posedge reset)
						begin
							if(reset)
							begin
								cur_state <= WAIT;
							end
							else
								cur_state <= next_state;
							
						end
						
						always_latch
						begin
							next_state <= cur_state;
							
							if(init == 1'b1)
							begin
								next_state <= CONFLICT;
								schedule <= 1'b1;
							end
							
							if(cur_state != WAIT)
							begin
								cpu_ready = 1'b0;
								if(cpu_write == 1'b1)
									cpu_out <= cpu_in;
								else
									cpu_out <= data_in;
							end
							else
							begin
								cpu_ready = 1'b1;
							end
							
							if(addr_reg != addr)
							begin
								schedule <= 1'b1;
								next_state <= CONFLICT;
							end
								
							if(resolved)
							begin
								next_state <= WAIT;
								addr_reg <= addr;
								schedule <= 1'b0;
							end
							
						end
						
						endmodule
						
						