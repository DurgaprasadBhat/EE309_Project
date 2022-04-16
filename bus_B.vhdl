library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;

ENTITY b16 IS 
	generic( N : integer := 16);

    PORT(
        IN_t1   : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input
        IN_RF_b   : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input
        en_t1  : IN STD_LOGIC; -- load/enable.
        en_RF_b  : IN STD_LOGIC; -- load/enable.
        clr : IN STD_LOGIC;
        clk : IN STD_LOGIC; -- clock.
        q   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) -- output
    );
    END b16;

    ARCHITECTURE regb16 OF b16 IS

    BEGIN
        process(clr, IN_t1, IN_RF_b, en_t1, en_RF_b)
        begin
            if en_t1 = '1' then
                q <= IN_t1;
            elsif en_RF_b then
                q <= IN_RF_b;
            else 
                NULL;
            end if;
        end process;
    END regb16;