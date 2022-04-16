library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;


ENTITY register16 IS 
	generic( N : integer := 16);

PORT(
    d   : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input
    ld  : IN STD_LOGIC; -- load/enable.
    clr : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
    q   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) -- output
);
END register16;

ARCHITECTURE regArch OF register16 IS

BEGIN
    process(clk, clr)
    begin
        if clr = '1' then --clear register if clr is set
            q <= x"0000";
        elsif rising_edge(clk) then --write the register on rising edge of clock
            if ld = '1' then
                q <= d;
            end if;
        end if;
    end process;
END regArch;
