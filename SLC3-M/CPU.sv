module CPU(	input	logic 		Clk, Reset, Run, Continue,
				input logic [15:0] index,
				output logic		Mem_CE, Mem_UB, Mem_LB, Mem_OE, Mem_WE,
				output logic[19:0]ADDR,
				input logic			[15:0]Data_in,
				output logic [15:0]Data_out,
				input logic mem_ready,
				output logic sync_b,halt_b);
				
logic			LD_MAR, LD_MDR, LD_IR, LD_CC, LD_REG, LD_PC;
logic			GatePC, GateMDR, GateALU, GateMARMUX;
logic	[1:0]	PCMUX;
logic			SR2MUX, ADDR1MUX, ADDR2MUX, MARMUX;
logic [2:0]	DR, SR1, SR2, NZP;
logic	[2:0] ALUK;
logic [15:0]PCin, PCout, IRout, MARin, MARout, MDRout, ALUout, SR1out, SR2out, imm5, B, PCoffset9, PCoffset11, PCoffset, MARoffset6, MEM_IOaddr;
logic [4:0] State;


SEXT9			BR_PCin		(.In(IRout[8:0]), .Out(PCoffset9));	
SEXT11		JSR_PCin		(.In(IRout[10:0]), .Out(PCoffset11));
Mux2			PCoffsetmux	(.Sel(ADDR1MUX), .Din0(PCoffset9)/*BR*/, .Din1(PCoffset11)/*JSR*/, .Dout(PCoffset));
Mux4			PCmux			(.Sel(PCMUX), .Din0(PCout+1)/*FETCH*/, .Din1(PCout+PCoffset)/*BR and JSR*/, .Din2(SR2out)/*JMP*/, .Din3(Data_in)/*Switches*/, .Dout(PCin));
Reg16 		PC				(.*, .Load(LD_PC), .Din(PCin), .Dout(PCout)); 
datapath_control Dcontrol (.*, .MAR(Marout), .PC(PCout), .ALU(ALUout), .MDR(MDRout), .Mem_OE(~Mem_OE));

Reg16			IR				(.*, .Load(LD_IR), .Din(Data_out), .Dout(IRout));

SEXT6			LDR_MARin	(.In(IRout[5:0]), .Out(MARoffset6));
Mux2			MEM_IOmux	(.Sel(ADDR2MUX), .Din0(MARoffset6+SR2out), .Din1(16'hFFFF), .Dout(MEM_IOaddr));	// BaseR+offset for LDR/STR and FFFF for loading PC when starting execution
Mux2			MARmux		(.Sel(MARMUX), .Din0(Data_out)/*PC*/, .Din1(MEM_IOaddr), .Dout(MARin));
Reg16			MAR			(.*, .Load(LD_MAR), .Din(Data_out), .Dout(MARout));

Reg16 		MDR			(.*, .Load(LD_MDR), .Din(Data_out), .Dout(MDRout));

RegAddrMux	regAddrMux	(.*, .IR(IRout));						// SR		= SR1 when there's only one source register
RegFile		Registers	(.*, .Load(LD_REG), .Din(Data_out));	//	BaseR = SR1 for JMP, LDR, STR

SEXT5			operand2sext(.In(IRout[4:0]), .Out(imm5));
Mux2			SR2mux		(.Sel(SR2MUX), .Din0(SR2out)/*SR2 for ADD and AND*/, .Din1(imm5)/*immediate value for ADD and AND*/, .Dout(B));
ALU			alu			(.*, .A(SR1out));

NZPreg		nzpreg		(.*, .Load(LD_CC), .LastResult(Data_out));

ISDU			isdu			(.*, .IR(IRout), .State_out(State));

assign ADDR = {(4'b00), MARout};
assign LED = IRout[11:0]; //for pause instruction

//test_memory mem();

endmodule
