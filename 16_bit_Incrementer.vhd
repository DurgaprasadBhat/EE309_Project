library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity increment1 is
    port(
        t1 : in std_logic_vector(15 downto 0);
        pc : in std_logic_vector(15 downto 0);
		  sr : in std_logic_vector(2 downto 0);
		  sel : in std_logic_vector(1 downto 0);
        output : out std_logic_vector(15 downto 0)
    );
end increment1;


architecture Strombreaker of increment1 is

begin
  process(t1, pc, sr, sel)
  begin
	case(sel) is
	when "00" => 
			output <= std_logic_vector(unsigned(sr) + 1);
	when "01" =>
			output <= std_logic_vector(unsigned(pc) + 1);
   when "10" => 
			output <= std_logic_vector(unsigned(t1) + 1);
	end case;

	end process;
end Strombreaker;	
			
  