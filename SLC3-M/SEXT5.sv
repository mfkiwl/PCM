module SEXT5(	input logic [4:0]	In,
					output logic[15:0]Out);
					
always_comb
begin
	if(In[4])
		Out <= {(11'b11111111111),In};
	else
		Out <= {(11'b00000000000),In};
end

endmodule
