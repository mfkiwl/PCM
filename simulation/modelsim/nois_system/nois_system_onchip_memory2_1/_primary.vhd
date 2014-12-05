library verilog;
use verilog.vl_types.all;
entity nois_system_onchip_memory2_1 is
    generic(
        INIT_FILE       : string  := "nois_system_onchip_memory2_1.hex"
    );
    port(
        address         : in     vl_logic_vector(10 downto 0);
        address2        : in     vl_logic_vector(10 downto 0);
        byteenable      : in     vl_logic_vector(1 downto 0);
        byteenable2     : in     vl_logic_vector(1 downto 0);
        chipselect      : in     vl_logic;
        chipselect2     : in     vl_logic;
        clk             : in     vl_logic;
        clken           : in     vl_logic;
        clken2          : in     vl_logic;
        reset           : in     vl_logic;
        reset_req       : in     vl_logic;
        write           : in     vl_logic;
        write2          : in     vl_logic;
        writedata       : in     vl_logic_vector(15 downto 0);
        writedata2      : in     vl_logic_vector(15 downto 0);
        readdata        : out    vl_logic_vector(15 downto 0);
        readdata2       : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INIT_FILE : constant is 1;
end nois_system_onchip_memory2_1;
