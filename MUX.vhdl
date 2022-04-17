library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;


ENTITY MUX IS 
	generic( N : integer := 16);

PORT(
    inp1   : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input
    inp2   : in std_logic_vector(N-1 downto 0);
	 inp3:    IN STD_LOGIC_vector(N-1 downto 0); -- load/enable.
	 sel : in std_logic_vector(1 downto 0);
	 output:  out std_logic_vector(N-1 downto 0)
	 
);
END MUX;

ARCHITECTURE MURCH OF MUX IS

BEGIN
    process(inp1,inp2,inp3,sel)
    begin
        case(sel) is
		  when "00" =>
			output <= inp1;
		  when "01" => 
			output <= inp2;
		  when "10" =>
			output <= inp3;
		  when others =>
			NULL;
			end case;
    end process;
END MURCH;
