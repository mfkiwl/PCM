module Reg16(	input logic 		Clk, Reset, Load,	// 16 bit register
					input logic [15:0]Din,
					output logic[15:0]Dout
					);
					
always_ff @ (posedge Clk or posedge Reset)
begin
	if(Reset)
		Dout <= 16'h0000;
	else if(Load)
		Dout <= Din;
end

endmodule
