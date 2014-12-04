module testbench();

timeunit 10ns;//50 Mhz Clock 

timeprecision 1ns;

logic Clk = 0;
logic Reset, Run, Continue, ContinueIR; 
wire  [15:0]  I_O;
logic [19:0]  A;
logic [11:0] LED;
logic CE, UB, LB, OE, WE;
logic [6:0] HEX0, HEX1, HEX2, HEX3;
logic [15:0] PCout, IRout, Data_cpu_out, Other_out;
wire[15:0] index;

logic [15:0] S;

integer ErrorCnt = 0; //Error counter; succesful run means count=0

test_memory mem(.*, .Reset(~Reset));
												
SLC lc(.*, .DIS3(HEX3), .DIS2(HEX2), .DIS1(HEX1), .DIS0(HEX0), .Data(I_O));

always begin : CLOCK_GENERATION //1 timeunit delay
	#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
	Clk=0;
end

task test_setup(reg [15:0] addr);
@(posedge Clk)
#10 Reset = 0;

#10 Reset = 1;

#2 S= addr;

#100 Run = 0;

#10 Run = 1;

//#2 index = 16'hFFFF;
endtask

task test_add(int num1, int num2, reg [15:0] addr);
//@(posedge Clk)
	int sum = 0;
	sum = num1 + num2;
	test_setup(addr);
		
endtask
//Begin testing
initial begin: TEST_VECTORS
Reset = 1;
Run = 1;
Continue = 1;
//first function starting address will be loaded



begin
test_setup(16'h005A);


#100 Continue = 0;

#10 Continue = 1; 

#50 S = 16'h0606;


	



end

end


endmodule
