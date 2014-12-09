module ALU(	input logic [2:0]	ALUK,
				input logic	[15:0]A, B,
				output logic[15:0]ALUout);
				
always_comb
begin
	ALUout <= 16'h0000;
	case(ALUK)
		3'b000: ALUout <= (A+B);
		3'b001: ALUout <= (A&B);
		3'b010: ALUout <= (~A);
		3'b011: ALUout <= A;	// unmodified register value for JMP
		3'b100: ALUout <= (A-B);
		3'b101: ALUout <= (A*B);
		3'b110: ALUout <= (A/B);
		
	endcase
end

endmodule
