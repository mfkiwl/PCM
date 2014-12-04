module SEXT11(	input logic [10:0]In,
					output logic[15:0]Out);
					
always_comb
begin
	if(In[10])
		Out <= {(5'b11111),In};
	else
		Out <= {(5'b00000),In};
end

endmodule
