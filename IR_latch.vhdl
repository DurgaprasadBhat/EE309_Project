library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY IR_L IS 
	generic( N : integer := 16);

PORT(
    d   : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input
    ld  : IN STD_LOGIC; -- load/enable.
    q   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) -- output
);
END IR_L;

ARCHITECTURE regArch OF IR_L IS

BEGIN
process(d, ld)
begin 
if(ld = '1') then
q <= d;
end if;
end process;
end regArch;