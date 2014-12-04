module TSB(	input logic			Switch,	// tristate buffer
				input logic	[15:0]Din,
				output logic[15:0]Dout);
				
always_comb
begin
	Dout <= 16'bZZZZZZZZZZZZZZZZ;	// set output to HiZ unless the switch tells it to let the input through
	if(Switch)
		Dout <= Din;
end

endmodule
