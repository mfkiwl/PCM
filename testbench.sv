module testbench();
 
timeunit 10ns;//50 Mhz Clock
 
timeprecision 1ns;
 
logic Clk = 0;
logic Reset, Run;
logic Continue;

//logic ContinueIR;
wire  [15:0]  I_O;
logic [15:0] Data_in,Data_out;
wire[15:0] index;
logic [19:0]  A;
logic mem_ready;
//logic [11:0] LED;
logic CE, UB, LB, OE, WE;
/*logic [6:0] HEX0, HEX1, HEX2, HEX3;
logic [15:0] PCout, IRout, Data_cpu_out, Other_out;
logic [12:0] sdram_wire_addr;
logic  [1:0] sdram_wire_ba;
logic        sdram_wire_cas_n;
logic           sdram_wire_cke;
logic           sdram_wire_cs_n;
logic  [31:0] sdram_wire_dq;
logic  [3:0] sdram_wire_dqm;
logic           sdram_wire_ras_n;
logic           sdram_wire_we_n;
logic           sdram_wire_clk;
*/
logic	Mem_CE, Mem_UB, Mem_LB, Mem_OE, Mem_WE;
logic[19:0]ADDR;
//PCM_MM Variables

logic cpu0_write,init;                                                                              
logic [19:0] cpu0_addr;
logic [15:0] cpu0_data_in;
logic cpu0_ready;
logic [15:0] cpu0_data_out;
logic cpu1_write;                                                                              
logic[19:0] cpu1_addr;
logic[15:0] cpu1_data_in;
logic cpu1_ready;
logic [15:0] cpu1_data_out;
logic cpu2_write;                                                                      
logic[19:0] cpu2_addr;
logic[15:0] cpu2_data_in;
logic cpu2_ready;
logic [15:0] cpu2_data_out;
logic cpu3_write;                                                                      
logic[19:0] cpu3_addr;
logic[15:0] cpu3_data_in;
logic cpu3_ready;
logic [15:0] cpu3_data_out;
logic [10:0] pcm_mem_mm_address;
logic pcm_mem_mm_chipselect;
logic pcm_mem_mm_clken;
logic pcm_mem_mm_write;
logic  [15:0] pcm_mem_mm_readdata;
logic [15:0] pcm_mem_mm_writedata;
logic [1:0] pcm_mem_mm_byteenable;

//PCM_MM_REG variables

logic resolved, cpu_write;
logic [19:0] addr;
logic [15:0] data_in, cpu_in;
logic schedule, cpu_ready;
logic [15:0] cpu_out;
logic [19:0] addr_reg;


logic [3:0] pccm_ctl_con_export;	// used for NIOS to PCCM control communication
logic [3:0] pccm_rsp_con_export;	// used for PCCM to NIOS control communication
logic cpu0_sync, cpu1_sync, cpu2_sync, cpu3_sync, cpu0_halt, cpu1_halt, cpu2_halt, cpu3_halt;
logic int_reset, int_init, cpu0_Continue, cpu1_Continue, cpu2_Continue, cpu3_Continue;

//PCCM control(.*, .clk(Clk), .reset(~Reset));

 
//logic [15:0] S;
 
integer ErrorCnt = 0; //Error counter; succesful run means count=0
 
//test_memory mem(.*, .Reset(~Reset));
                                                                                               
//SLC lc(.*, .DIS3(HEX3), .DIS2(HEX2), .DIS1(HEX1), .DIS0(HEX0), .Data(I_O));
 
//SOC_W_PCM soc(.*, .clk(Clk), .reset(~Reset));
 
PCM_MM pcm (.*, .clk(Clk), .reset(~Reset));
 
//PCM_MM_reg pcm_reg(.*, .clk(Clk), .reset(~Reset));

//CPU tcpu(.*,.Reset(~Reset));
 
always begin : CLOCK_GENERATION //1 timeunit delay
        #1 Clk = ~Clk;
end
 
initial begin: CLOCK_INITIALIZATION
        Clk=0;
end
task test_cpu1(reg [15:0] instr);
@(posedge Clk)
#5 Reset = 0;

#5 Reset = 1;

#1 mem_ready =1;

#5 Data_in =16'b0010110000000111;

#25 Data_in = instr;


endtask

/*task test_add(int num1, int num2, reg [15:0] addr);
//@(posedge Clk)
	int sum = 0;
	sum = num1 + num2;
	test_setup(addr);
		
endtask

task PCM_MM_REG_test(reg [19:0] newaddr);
@(posedge Clk)
addr = 20'h00000;
data_in = 16'h0101;
#1 init = 1'b1;
#2 init = 1'b0;
#4 resolved = 1'b1;
#1 resolved = 1'b0;
#2 addr =newaddr ;

#1 if(schedule == 1)
begin
#5	$display ("Schedule was set correctly");
end
else
begin
#5	$display ("Schedule was not correctly");
end

#5 data_in = 16'h0FF0;

#5 resolved = 1 ;

#20 if(cpu_ready == 1)
begin
#5 $display ("cpu_ready was set correctly");
end
else
begin
#5 $display ("cpu_ready was not set correctly");
end
#5 Reset = 0;	

endtask
*/
task PCM_MM_test0(reg [10:0] newaddr, reg [15:0] newdata);
cpu0_addr = 16'b0;
cpu1_addr = 16'b0;
cpu2_addr = 16'b0;
cpu3_addr = 16'b0;
pcm_mem_mm_readdata = 15'b0;
#1 init = 1'b1;
#2 init = 1'b0;
#40 cpu0_addr = newaddr;
pcm_mem_mm_readdata = newdata;

#10 if(cpu0_addr == pcm_mem_mm_address )
begin
#5 $display ("pcm_mem_mm_address was set correctly");
end
else
begin
#5 $display ("pcm_mem_mm_address was not set correctly");
end

#10 if(cpu0_ready)
begin
	#1 if(pcm_mem_mm_readdata == cpu0_data_out)
	begin
	#5 $display ("pcm_mem_mm_readdata was set correctly");
	end
	else
	begin
	#5 $display ("pcm_mem_mm_readdata was not set correctly");
	end
end


endtask

//Begin testing
initial begin: TEST_VECTORS
Reset = 1;
Run = 1;
Continue = 1;


begin
//#5 PCM_MM_REG_test(20'hFFFFF);
Reset = 0;

#2 Reset = 1;

#5 PCM_MM_test0(10'h066, 16'h9999);


	
end

end


endmodule
