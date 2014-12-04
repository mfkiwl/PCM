module RegFile (	input logic 		Clk, Reset, Load,
						input logic [2:0]	SR1, SR2, DR,
						input logic [15:0] index,
						input logic [15:0]Din,
						output logic[15:0]SR1out, SR2out
						);

logic Ld0, Ld1, Ld2, Ld3, Ld4, Ld5, Ld6, Ld7;
logic [15:0] Dout0, Dout1, Dout2, Dout3, Dout4, Dout5, Dout6, Dout7;

						
//Reg16 R0(.*, .Load(Ld0), .Dout(index));
Reg16 R1(.*, .Load(Ld1), .Dout(Dout1));
Reg16 R2(.*, .Load(Ld2), .Dout(Dout2));
Reg16 R3(.*, .Load(Ld3), .Dout(Dout3));
Reg16 R4(.*, .Load(Ld4), .Dout(Dout4));
Reg16 R5(.*, .Load(Ld5), .Dout(Dout5));
Reg16 R6(.*, .Load(Ld6), .Dout(Dout6));
Reg16 R7(.*, .Load(Ld7), .Dout(Dout7));

always_comb
begin
	
	case(SR1)	// provide the corresponding register outputs for the source register addresses provided
		3'b000: SR1out <= index;
		3'b001: SR1out <= Dout1;
		3'b010: SR1out <= Dout2;
		3'b011: SR1out <= Dout3;
		3'b100: SR1out <= Dout4;
		3'b101: SR1out <= Dout5;
		3'b110: SR1out <= Dout6;
		3'b111: SR1out <= Dout7;		
	endcase
	
	case(SR2)
		3'b000: SR2out <= index;
		3'b001: SR2out <= Dout1;
		3'b010: SR2out <= Dout2;
		3'b011: SR2out <= Dout3;
		3'b100: SR2out <= Dout4;
		3'b101: SR2out <= Dout5;
		3'b110: SR2out <= Dout6;
		3'b111: SR2out <= Dout7;
	endcase
	
	Ld0 <= 1'b0;	// initially set all load signals to 0
	Ld1 <= 1'b0;
	Ld2 <= 1'b0;
	Ld3 <= 1'b0;
	Ld4 <= 1'b0;
	Ld5 <= 1'b0;
	Ld6 <= 1'b0;
	Ld7 <= 1'b0;
	
	if(Load)
	begin
		case(DR)	// only allow load to be 1 for the register with the DR address
			//3'b000: Ld0 <= 1'b1;
			3'b001: Ld1 <= 1'b1;
			3'b010: Ld2 <= 1'b1;
			3'b011: Ld3 <= 1'b1;
			3'b100: Ld4 <= 1'b1;
			3'b101: Ld5 <= 1'b1;
			3'b110: Ld6 <= 1'b1;
			3'b111: Ld7 <= 1'b1;	
			default: ;
		endcase
	end
end
						
endmodule
						