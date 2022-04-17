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
			  sel : in std_logic_vector(1 downto 0);
			  CY : out std_logic;
			  Z : out std_logic;
			  Z_out : out std_logic
  );
end ALU;
		
architecture badabingbadabamtuss of ALU is

signal temp : std_logic_vector(N-1 downto 0);
signal a0, a1, a2,zz : std_logic;
signal opr : std_logic_vector(1 downto 0);
begin 
process(INPUT1, INPUT2, OP)
begin

case (sel) is
 when "00" => 
		a0 <= '0';
		a1 <= '0';
		a2 <= '0';
 when "01" => 
		a0 <= '0';
		a1 <= '1';
		a2 <= '1';
 when "10" => 
		a0 <= '0';
		a1 <= '0';
		a2 <= '1';
 when "11" => 
		a0 <= '1';
		a1 <= '0';
		a2 <= '0';		
	end case;	
case (a0) is
		when '0' => opr <= OP;
		when '1' => opr <= "11";	
 end case;

case(opr) is

when "00" =>
	temp <= std_logic_vector(signed(INPUT1) + signed(INPUT2)); --signed Addition
	OUTPUT <= temp;
 	if temp = "0000000000000000" then
		zz <= '1'; --set Zero flag 
	else
		zz <= '0';
	end if;
	Z_out <= zz;
	if a2 = '1' then Z <= zz; 
	end if;
	
	if a1 = '1' then
	
	if ((INPUT1(15) xnor INPUT2(15)) and (INPUT1(15) xor temp(15))) = '1' then
		CY <= '1';
	else 
		CY <= '0';
	end if;
	end if;
-- if both input have same sign and output has different sign then set Carry Flag
when "01" =>
	OUTPUT <= INPUT1 nand INPUT2;
	OUTPUT <= temp;
 	if temp = "0000000000000000" then --Zero Flag condition
		zz <= '1';
	else
		zz <= '0';
	end if;
	Z_out <= zz;
	if a2 = '1' then Z <= zz; 
	end if;
when "10" =>
	OUTPUT <= std_logic_vector(signed(INPUT1) - signed(INPUT2)); -- signed Sub
	OUTPUT <= temp;
 	if temp = "0000000000000000" then -- Zero flag condition
		zz <= '1';
	else
		zz <= '0';
	end if;
	Z_out <= zz;
	if a2 = '1' then Z <= zz; 
	end if;
when others =>
	NULL;
end case;
end process;
end badabingbadabamtuss;