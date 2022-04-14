library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;

entity ALU is
	generic ( N: integer:=16
  );
    Port ( INPUT1 : in  STD_LOGIC_VECTOR(N-1 downto 0);
			  INPUT2 : in STD_LOGIC_VECTOR(N-1 downto 0); 	
			  OP : in  STD_LOGIC_VECTOR(1 downto 0); 
			  OUTPUT: out  STD_LOGIC_VECTOR(N-1 downto 0);
			  CY : out std_logic;
			  Z : out std_logic
  );
end ALU;
		
architecture badabingbadabamtuss of ALU is

signal temp : std_logic_vector(N-1 downto 0);


begin 
process(INPUT1, INPUT2, OP)
begin
case(OP) is

when "00" =>
	temp <= std_logic_vector(signed(INPUT1) + signed(INPUT2)); --signed Addition
	OUTPUT <= temp;
 	if temp = "0000000000000000" then
		Z <= '1'; --set Zero flag 
	else
		Z <= '0';
	end if;
	if ((INPUT1(15) xnor INPUT2(15)) and (INPUT1(15) xor temp(15))) = '1' then
		CY <= '1';
	else 
		CY <= '0';
	end if;
-- if both input have same sign and output has different sign then set Carry Flag
when "01" =>
	OUTPUT <= INPUT1 nand INPUT2;
	OUTPUT <= temp;
 	if temp = "0000000000000000" then --Zero Flag condition
		Z <= '1';
	else
		Z <= '0';
	end if;
	
when "10" =>
	OUTPUT <= std_logic_vector(signed(INPUT1) - signed(INPUT2)); -- signed Sub
	OUTPUT <= temp;
 	if temp = "0000000000000000" then -- Zero flag condition
		Z <= '1';
	else
		Z <= '0';
	end if;
when others =>
	NULL;
end case;
end process;
end badabingbadabamtuss;