module SEXT6(	input logic [5:0]	In,
					output logic[15:0]Out);
					
always_comb
begin
	if(In[5])
		Out <= {(10'b1111111111),In};
	else
		Out <= {(10'b0000000000),In};
end

endmodule
