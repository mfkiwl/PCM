library verilog;
use verilog.vl_types.all;
entity test_memory is
    generic(
        size            : integer := 256
    );
    port(
        Clk             : in     vl_logic;
        Reset           : in     vl_logic;
        I_O             : inout  vl_logic_vector(15 downto 0);
        A               : in     vl_logic_vector(19 downto 0);
        CE              : in     vl_logic;
        UB              : in     vl_logic;
        LB              : in     vl_logic;
        OE              : in     vl_logic;
        WE              : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of size : constant is 1;
end test_memory;
