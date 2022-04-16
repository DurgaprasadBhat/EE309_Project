library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;


ENTITY T1 IS 

PORT(
    inp_b16   : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --b16 input 
	 b16_wr_en : in  std_logic;
	 inp_inc   : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --inc input
	 inc_wr_en : in  std_logic;
	 inp_alu   : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --alu input
	 alu_wr_en : in  std_logic;
    clk : IN STD_LOGIC; -- clock.
    output   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) -- output
);
END T1;

ARCHITECTURE regArch OF T1 IS

BEGIN
    process(clk)
    begin
		  if rising_edge(clk) then --write the register on rising edge of clock
            if b16_wr_en = '1' then
                output <= inp_b16;
				elsif inc_wr_en = '1' then
                output <= inp_inc;
				elsif alu_wr_en = '1' then
                output <= inp_alu;
            end if;
        end if;
    end process;
END regArch;