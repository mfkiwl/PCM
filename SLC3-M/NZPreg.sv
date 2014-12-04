module NZPreg(	input logic			Clk, Reset, Load,
					input logic	[15:0]LastResult,	
					output logic[2:0]	NZP);

logic [2:0] NZPin;
					
always_comb
begin
	if(LastResult[15])					// if the MSB is 1 it's negative
		NZPin <= 3'b100;
	else if(LastResult == 16'h0000)	// if all bits are 0 then it's 0
		NZPin <= 3'b010;
	else										// otherwise it's positive
		NZPin <= 3'b001;
end
					
always_ff @ (posedge Clk or posedge Reset)
begin
	if(Reset)
		NZP <= 3'b000;
	else if(Load)
		NZP <= NZPin;
end

endmodule
