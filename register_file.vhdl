library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
  port(
    outA        : out std_logic_vector(15 downto 0);
    outB        : out std_logic_vector(15 downto 0);
    inputA       : in  std_logic_vector(15 downto 0);
	 inputB       : in  std_logic_vector(15 downto 0);
	 incr        : in std_logic_vector(15 downto 0);
	 to_inc      : out std_logic_vector(15 downto 0);
	 ren1        : in  std_logic;
	 ren2        : in std_logic;
    writeEnable1 : in  std_logic;
	 inc_wr_en   : in  std_logic;
	 b_wr_en     : in std_logic;
    regASel     : in  std_logic_vector(2 downto 0);
    regBSel     : in  std_logic_vector(2 downto 0);
    writeRegSel : in  std_logic_vector(2 downto 0);
	 clk         : in  std_logic
    );
end register_file;


architecture behavioral of register_file is
  type registerFile is array(0 to 7) of std_logic_vector(15 downto 0);
  signal registers : registerFile;
begin
  regFile : process (clk) is
  begin
    if rising_edge(clk) then
	   if (ren1 ='1') then
      -- Read A and B before bypass
      outA <= registers(to_integer(unsigned(regASel)));
		end if;
		if (ren2 = '1') then
      outB <= registers(to_integer(unsigned(regBSel)));
		end if; 
      -- Write and bypass
      if writeEnable1 = '1' then
        registers(to_integer(unsigned(writeRegSel))) <= inputA;  -- Write
		end if;
--        if regASel = writeRegSel then  -- Bypass for read A
--          outA <= input;
--        end if;
--        if regBSel = writeRegSel then  -- Bypass for read B
--          outB <= input;
--        end if;
		if (inc_wr_en = '1') then
		registers(7) <= incr;
		end if;
		if (b_wr_en = '1') then
		registers(7) <= inputB;
		end if;
	 to_inc <= registers(7);
    end if;
  end process;
end behavioral;