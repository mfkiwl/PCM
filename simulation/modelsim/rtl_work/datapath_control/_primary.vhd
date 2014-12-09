library verilog;
use verilog.vl_types.all;
entity datapath_control is
    port(
        MAR             : in     vl_logic_vector(15 downto 0);
        PC              : in     vl_logic_vector(15 downto 0);
        ALU             : in     vl_logic_vector(15 downto 0);
        MDR             : in     vl_logic_vector(15 downto 0);
        Data_in         : in     vl_logic_vector(15 downto 0);
        GateMARMUX      : in     vl_logic;
        GateMDR         : in     vl_logic;
        GatePC          : in     vl_logic;
        GateALU         : in     vl_logic;
        Mem_OE          : in     vl_logic;
        Data_out        : out    vl_logic_vector(15 downto 0)
    );
end datapath_control;
