library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;


ENTITY IR IS 
	generic( N : integer := 16);

PORT(
    d   : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --input
    en  : IN STD_LOGIC; -- load/enable.
    clk : IN STD_LOGIC; -- clock.
    q   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) -- output
);
END IR;

ARCHITECTURE IRArch OF IR IS

BEGIN
    process(clk)
    begin
        if rising_edge(clk) then --write the register on rising edge of clock
            if en = '1' then
                q <= d;
            end if;
        end if;
    end process;
END IRArch;




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;


entity IRdec is
port (inp : in std_logic_vector(1 downto 0);
		output: out std_logic_vector(2 downto 0));
end IRdec;

architecture irdecoder1 of IRdec is

begin
		output(2) <= inp(1);
		output(1) <= inp(1) and (not inp(0));
		output(0) <= inp(1) or inp(0);
end irdecoder1;