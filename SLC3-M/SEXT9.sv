module SEXT9(	input logic [8:0]	In,
					output logic[15:0]Out);
					
always_comb
begin
	if(In[8])
		Out <= {(7'b1111111),In};
	else
		Out <= {(7'b0000000),In};
end

endmodule
