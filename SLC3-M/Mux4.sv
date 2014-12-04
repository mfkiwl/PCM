module Mux4(input logic [1:0]	Sel,							// 4 to 1 mux
				input logic [15:0]Din0, Din1, Din2, Din3,
				output logic[15:0]Dout);
				
always_comb
begin
	case(Sel)
		2'b00: Dout = Din0;
		2'b01: Dout = Din1;
		2'b10: Dout = Din2;
		2'b11: Dout = Din3;
	endcase
end

endmodule
