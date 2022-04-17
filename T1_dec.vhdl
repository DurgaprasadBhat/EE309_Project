library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;


entity T1_dec is
 port(inp : in std_logic_vector(2 downto 0);
		  output : out std_logic_vector(4 downto 0)
		 );
		
end T1_dec;

architecture tada of T1_dec is

begin
		output(4) <= inp(0) and (not inp(1)) and (not inp(2));
		output(3) <= ((not inp(0)) and (not inp(1)) and (not inp(2))) or (inp(0) and inp(1));
		output(2) <= inp(1) and (not inp(0)) and (not inp(2));
		output(1) <= (inp(1) and inp(0)) or (inp(0) and inp(2));
		output(0) <= inp(1) and inp(2);
end tada;