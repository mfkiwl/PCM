module datapath_control(input [15:0] MAR, PC, ALU, MDR,Data_in,
				  input logic GateMARMUX, GateMDR, GatePC, GateALU, Mem_OE,
				  output logic [15:0] Data_out);
				  
				  //Logic for the datapath wire
				  always_comb
				  begin
				  
						
						case ({GateMARMUX, GateMDR, GatePC, GateALU, Mem_OE})
							4'b10000 :
								Data_out = MAR;
							4'b01000 :
								Data_out = MDR;
							4'b00100 :
								Data_out = PC;
							4'b00010 :
								Data_out = ALU;
							4'b00001 :
								Data_out = Data_in;	
							default :
								Data_out = 16'b1010101010101010;
						
						endcase
						
				  
				  end

				  endmodule
				  