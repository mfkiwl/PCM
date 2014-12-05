module PCM_MM_reg(input logic clk, reset, resolved, cpu_write,
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
								cpu_out <= 16'h0000;
								addr_reg <= 16'h0000;
								cur_state <= WAIT;
								next_state <= WAIT;
							end
							
							cur_state <= next_state;
							
						end
						
						always_latch
						begin
							if(!WAIT)
							begin
								if(cpu_write)
									cpu_out <= cpu_in;
								else
									cpu_out <= data_in;
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
							end
							
							if(cur_state == WAIT)
								cpu_ready = 1'b1;
						end
						
						endmodule
						
						