library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity BBBB is

	port( SRin : in std_logic_vector(2 downto 0);
			IRin : in std_logic_vector(15 downto 0);
			b: out std_logic);
end  BBBB;			
architecture babablacksheep of BBBB is
begin 
		process(SRin, IRin) 
			begin 
				b <= IRin(to_integer(unsigned(SRin)));
			end process;
			
end babablacksheep;