library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;


ENTITY a16 IS 
	generic( N : integer := 16);

PORT(
    in_DI: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input_from DI
    in_RFa  : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- inptu_from RFa.
	 in_T1 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input_from T1.
	 in_IR: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input_from IR--> Shifter.
	 en_DI: IN STD_LOGIC;
	 en_RFa : IN STD_LOGIC;
	 en_T1 : IN STD_LOGIC;
	 en_IR : IN STD_LOGIC;
    q   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) -- output
);
END a16;
 ARCHITECTURE behav of a16 is

BEGIN
PROCESS(in_DI, in_RFa, in_T1, in_DI, en_DI, en_RFa, en_IR, en_T1)
begin 
if (en_DI = '1') then
q <= in_DI;
elsif (en_RFa = '1') then
q <= in_RFa;
elsif (en_T1 = '1') then
q <= in_T1;
elsif (en_IR ='1') then
q <= in_IR;
else
NULL;
end if;
end process;
end behav;
 