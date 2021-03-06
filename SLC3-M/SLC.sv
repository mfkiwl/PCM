module SLC(	input logic			Clk, Reset, Run, Continue, ContinueIR, // CPU input // top module when using SRAM
				input logic [15:0]S,								// Mem2IO input
				output logic		CE, UB, LB, OE, WE,		// CPU output directly to memory
				output logic[19:0]A,								// CPU output directly to memory
				output logic[11:0]LED,							// CPU output
				output logic [6:0]DIS3, DIS2, DIS1, DIS0,	// Mem2IO output
				input logic	[15:0]Data_in,
				output logic [15:0]Data_out,
				inout wire [15:0] index,
				output logic sync_b,halt_b);					// Mem2IO inout

logic Mem_CE, Mem_UB, Mem_LB, Mem_OE, Mem_WE;
logic [19:0] ADDR;
logic [3:0]	 HEX3, HEX2, HEX1, HEX0;
tri	[15:0] CPUdata;
logic mem_ready;

//CPU		cpu	(.*, .Reset(~Reset), .Run(~Run), .Continue(~Continue), .ContinueIR(~ContinueIR), .Data_in(CPUdata));

Mem2IO 	mem2io(.*, .Reset(~Reset), .A(ADDR), .CE(Mem_CE), .UB(Mem_UB), .LB(Mem_LB), .OE(Mem_OE), .WE(Mem_WE),
						.Switches(S), .Data_CPU(CPUdata), .Data_Mem(Data));
						
HexDriver H3(.In0(HEX3), .Out0(DIS3));
HexDriver H2(.In0(HEX2), .Out0(DIS2));
HexDriver H1(.In0(HEX1), .Out0(DIS1));
HexDriver H0(.In0(HEX0), .Out0(DIS0));
					  
assign CE = Mem_CE;
assign UB = Mem_UB;
assign LB = Mem_LB;
assign OE = Mem_OE;
assign WE = Mem_WE;

assign A = ADDR;

endmodule
