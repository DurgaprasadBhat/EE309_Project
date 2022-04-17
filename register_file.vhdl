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
  -- Read A and B before bypass
  outA <= registers(to_integer(unsigned(regASel)));
  outB <= registers(to_integer(unsigned(regBSel)));

    if rising_edge(clk) then
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;

entity regFileDec is
port (inp:in std_logic_vector(7 downto 0);
		output:out std_logic_vector(10 downto 0));
		
end regFileDec;

architecture wefohu of regFileDec is
begin
	process(inp)
	begin
	output(3 downto 0) <= inp(3 downto 0);
	
	case(inp(5 downto 4)) is
	when "00" => 
		output(7 downto 4) <= "0010";
	when "01" => 
		output(7 downto 4) <= "0001";
	when "10" => 
		output(7 downto 4) <= "1001";
	when "11" => 
		output(7 downto 4) <= "0100";
	end case;

	case(inp(7 downto 6)) is
		
	when "00" =>
		output(10 downto 8) <= "000";
	when "01" =>
		output(10 downto 8) <= "100";		
	when "10" =>
		output(10 downto 8) <= "110";
	when "11" =>
		output(10 downto 8) <= "001";
	end case;
	end process;
end wefohu;	