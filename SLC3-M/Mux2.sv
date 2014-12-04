module Mux2(input logic 		Sel,			// 2 to 1 mux
				input logic [15:0]Din0, Din1,
				output logic[15:0]Dout);
				
always_comb
begin
	if(Sel == 1'b0)
		Dout = Din0;
	else
		Dout = Din1;
end

endmodule
