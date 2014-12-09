//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    17:44:03 10/08/06
// Design Name:    ECE 385 Lab 10 Given Code - Incomplete ISDU
// Module Name:    ISDU - Behavioral
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Fall 2013 Distribution
//------------------------------------------------------------------------------


module ISDU(input	logic			Clk, 
										Reset,
										Run,
										Continue,
										mem_ready,

				input logic [2:0] NZP,
				input logic	[15:0]IR,
				  
				output logic		LD_MAR,
										LD_MDR,
										LD_IR,
										LD_CC,
										LD_REG,
										LD_PC,
									
				output logic 		GatePC,
										GateMDR,
										GateALU,
										GateMARMUX,
									
				output logic[1:0] PCMUX,
				output logic 		SR2MUX,
										ADDR1MUX,
										ADDR2MUX,
										MARMUX,
					  
				output logic[2:0] ALUK,
					  
				output logic 		Mem_CE,
										Mem_UB,
										Mem_LB,
										Mem_OE,
										Mem_WE, 
				output logic[5:0] State_out,
				output logic sync_b,halt_b);

 
enum logic [5:0] {Halted, 
						LoadPC1, LoadPC2, LoadPC3, LoadPC4,
						Fetch1, Fetch2, Fetch3, Fetch4,
						Decode,
						ADD, AND, NOT, BR, JMP,
						SUB,MULT,DIV,LEA,ST,LD,LD_1,
						LDR1, S25_1, S25_2, S27,
						STR1, S23_1, S23_2, S16,
						SYNC,HALT}   State, Next_state;   // Internal state logic
	 
       
always_ff @ (posedge Clk or posedge Reset )
begin : Assign_Next_State
	if (Reset) 
		State <= Halted;
	else 
		State <= Next_state;
end
   
       
always_comb
begin
	Next_state  = State;
	
	unique case (State)
		Halted:
		begin
			if (Continue) 
				Next_state <= Fetch1;
		end
		LoadPC1: Next_state <= LoadPC2;
		LoadPC2: Next_state <= LoadPC3;
		LoadPC3: Next_state <= LoadPC4;
		LoadPC4: Next_state <= Fetch1;
		Fetch1: Next_state <= Fetch2;
		Fetch2: Next_state <= Fetch3;
		Fetch3: Next_state <= Fetch4;
		Fetch4: 
		begin
			Next_state <= Halted;
		end
		Decode: 
			case (IR[15:12])
				4'b0000:
					begin
						if(NZP&IR[11:9])			// conditional statement for BR
							Next_state <= BR;
						else
							Next_state <= Fetch1;
					end
				4'b0001: Next_state <= ADD;
				4'b0010: Next_state <= LD;
				4'b0011: Next_state <= ST;
				4'b0100: Next_state <= HALT;
				4'b0101: Next_state <= AND;
				4'b0110: Next_state <= LDR1;
				4'b0111: Next_state <= STR1;
				4'b1001: Next_state <= NOT;
				4'b1010: Next_state <= MULT;
				4'b1011: Next_state <= DIV;
				4'b1100: Next_state <= JMP;
				4'b1101: Next_state <= SYNC;
				4'b1110: Next_state <= LEA;
				4'b1111: Next_state <= SUB;
				default: Next_state <= Fetch1;
			endcase
		ADD: Next_state <= Fetch1;
		LD: Next_state <= LD_1;
		LD_1: Next_state <= S25_1;
		ST: Next_state <= S23_1;
		HALT: 
		begin
			if (Continue) 
				Next_state <= HALT;
			else 
				Next_state <= Fetch1;
		end
		AND: Next_state <= Fetch1;
		NOT: Next_state <= Fetch1;
		MULT: Next_state <= Fetch1;
		DIV: Next_state <= Fetch1;
		LEA: Next_state <= Fetch1;
		SUB: Next_state <= Fetch1;
		BR: Next_state <= Fetch1;
		JMP: Next_state <= Fetch1;
		LDR1: Next_state <= S25_1;
		S25_1: 
		begin
			if (~mem_ready)
				Next_state <= S25_1;
			else
				Next_state <= S25_2;
		end
		S25_2: Next_state <= S27;
		S27: Next_state <= Fetch1;
		STR1: Next_state <= S23_1;
		S23_1: 
		begin
			if (~mem_ready)
				Next_state <= S23_1;
			else
				Next_state <= S23_2;
		end
		S23_2: Next_state <= S16;
		S16: Next_state <= Fetch1;
		SYNC:
		begin
			Next_state <= SYNC;
		/*
			if (~Continue) 
				Next_state <= SYNC;
			else 
				Next_state <= Fetch1;
		*/
		end
		default: ;
	endcase
end
   
       
always @ (State or IR[5])
begin 
	//default controls signal values; within a process, these can be
	//overridden further down (in the case statement, in this case)
	LD_MAR = 1'b0;
	LD_MDR = 1'b0;
	LD_IR = 1'b0;
	LD_CC = 1'b0;
	LD_REG = 1'b0;
	LD_PC = 1'b0;
	sync_b = 1'b0;
	halt_b = 1'b0;
		  
	GatePC = 1'b0;
	GateMDR = 1'b0;
	GateALU = 1'b0;
	GateMARMUX = 1'b0;
		  
	ALUK = 3'b000;
		  
	PCMUX = 2'b00;
	SR2MUX = 1'b0;
	ADDR1MUX <= 1'b0;
	ADDR2MUX <= 1'b0;
	MARMUX = 1'b0;
		  
	Mem_OE = 1'b1;
	Mem_WE = 1'b1;
		  
	case (State)
		Halted:;
		LoadPC1:	// MAR<-FFFF
			begin
			ADDR2MUX <= 1'b1;
			MARMUX <= 1'b1;
			GateMARMUX <= 1'b1;
			LD_MAR <= 1'b1;
			end
		LoadPC2:	// MDR<-switches
			Mem_OE <= 1'b0;
		LoadPC3:
			begin
			Mem_OE <= 1'b0;
			LD_MDR <= 1'b1;
			end
		LoadPC4:	// PC<-MDR
			begin
			GateMDR <= 1'b1;
			PCMUX <= 2'b11;
			LD_PC <= 1'b1;
			end
		Fetch1: // MAR<-PC, PC<-PC+1
			begin 
			GatePC <= 1'b1;
			LD_MAR <= 1'b1;
			PCMUX <= 2'b00;
			LD_PC <= 1'b1;
			end
		Fetch2: // MDR<-M[MAR]
			Mem_OE <= 1'b0;
		Fetch3:
			begin 
			Mem_OE <= 1'b0;
			LD_MDR <= 1'b1;
			end
		Fetch4: // IR<-MDR
			begin 
			GateMDR <= 1'b1;
			LD_IR <= 1'b1;
			end
		Decode: ;	// all this state does is decide what the next state should be based on the instruction
		ADD:	// R(DR)<-R(SR1)+(R(SR2) or SEXT(imm5)), load NZP
			begin 
			SR2MUX <= IR[5];
			ALUK <= 3'b000;
			GateALU <= 1'b1;
			LD_REG <= 1'b1;
			LD_CC <= 1'b1;
			end
		AND:	// R(DR)<-R(SR1)&(R(SR2) or SEXT(imm5)), load NZP
			begin 
			SR2MUX <= IR[5];
			ALUK <= 3'b001;
			GateALU <= 1'b1;
			LD_REG <= 1'b1;
			LD_CC <= 1'b1;
			end
		NOT:	// R(DR)<-~R(SR1), load NZP
			begin 
			ALUK <= 3'b010;
			GateALU <= 1'b1;
			LD_REG <= 1'b1;
			LD_CC <= 1'b1;
			end
		BR:	// PC<-PC+SEXT(PCoffset9)
			begin
			ADDR1MUX <= 1'b0;
			PCMUX <= 2'b01;
			LD_PC <= 1'b1;
			end
		JMP:	// PC<-R(SR2)
			begin
			PCMUX <= 2'b10;
			LD_PC <= 1'b1;
			end
		//JSR:	// R(7)<-PC, PC<-PC+SEXT(PCoffset11)
			//begin
			//ADDR1MUX <= 1'b1;
			//PCMUX <= 2'b01;
			//LD_PC <= 1'b1;
			//GatePC <= 1'b1;
			//LD_REG <= 1'b1;
			//end
		LDR1:	// MAR<-R(SR2)+SEXT(offset6)
			begin
			ADDR2MUX <= 1'b0;
			MARMUX <= 1'b1;
			GateMARMUX <= 1'b1;
			LD_MAR <= 1'b1;
			end
		S25_1:	// MDR<-M[MAR]
			Mem_OE <= 1'b0;
		S25_2: 
			begin 
			Mem_OE <= 1'b0;
			LD_MDR <= 1'b1;
			end
		S27:	// R(DR)<-MDR, load NZP
			begin
			GateMDR <= 1'b1;
			LD_REG <= 1'b1;
			LD_CC <= 1'b1;
			end
		STR1:	// MAR<-R(SR2)+SEXT(offset6)
			begin
			ADDR2MUX <= 1'b0;
			MARMUX <= 1'b1;
			GateMARMUX <= 1'b1;
			LD_MAR <= 1'b1;
			end
		S23_1:	// MDR<-R(SR1)
			begin
			ALUK <= 2'b11;
			GateALU <= 1'b1;
			LD_MDR <= 1'b1;
			end
		S23_2:	// M[MAR]<-MDR
			begin
			Mem_WE <= 1'b0;
			GateMDR <= 1'b1;
			end
		S16:
			begin
			Mem_WE <= 1'b0;
			GateMDR <= 1'b1;
			end
		SYNC: sync_b = 1'b1;	// like the decode state pause doesn't change any values
		HALT: halt_b = 1'b1;
		LD: 	
			begin
			ADDR1MUX <= 1'b0;
			PCMUX <= 2'b01;
			GatePC <= 1'b1;	
			end
		LD_1: 	
			begin
			ADDR1MUX <= 1'b0;
			PCMUX <= 2'b01;
			GatePC <= 1'b1;
			LD_MAR <= 1'b1;	
			end
		ST:
			begin
			ADDR1MUX <= 1'b0;
			PCMUX <= 2'b01;
			GatePC <= 1'b1;
			LD_MAR <= 1'b1;
			end
		SUB: 
			begin
			SR2MUX <= IR[5];
			ALUK <= 3'b100;
			GateALU <= 1'b1;
			LD_REG <= 1'b1;
			LD_CC <= 1'b1;
			end
		MULT: 
			begin
			SR2MUX <= IR[5];
			ALUK <= 3'b101;
			GateALU <= 1'b1;
			LD_REG <= 1'b1;
			LD_CC <= 1'b1;
			end
		DIV:  
			begin
			SR2MUX <= IR[5];
			ALUK <= 3'b110;
			GateALU <= 1'b1;
			LD_REG <= 1'b1;
			LD_CC <= 1'b1;
			end
		LEA:
			begin
			ADDR1MUX <= 1'b0;
			PCMUX <= 2'b01;
			GatePC <= 1'b1;
			LD_REG <= 1'b1;
			LD_CC <= 1'b1;
			end
		default: ;
	endcase
end
   
assign Mem_CE = 1'b0;
assign Mem_UB = 1'b0;
assign Mem_LB = 1'b0;
assign State_out = State;
	
endmodule
