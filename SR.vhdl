library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;


ENTITY SR IS 

PORT(
    inp_inc : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --input
    wr_en  : IN STD_LOGIC; -- load/enable.
    clk : IN STD_LOGIC; -- clock.
    output : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) -- output
);
END SR;

ARCHITECTURE regArch OF SR IS
signal y : std_logic_vector(2 downto 0) :="000";
    
BEGIN
    process(clk)
    begin
        if rising_edge(clk) then --write the register on rising edge of clock
            if wr_en = '1' then
                if unsigned(inp_inc) > 7 then
						y <= "000";
					 else
						y <= inp_inc(2 downto 0);
					 end if;
            end if;
        end if;
		  output <= y;
    end process;
END regArch;