library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SEXT5_0 is
  port ( data_in : in std_logic_vector(16 downto 0);
         data_out : out std_logic_vector(15 downto 0);
			sel : in std_logic_vector(0 downto 0));
end SEXT5_0;


architecture behavioral of SEXT5_0 is
begin
  process (data_in)
begin
  if (sel = "0") then
  data_out(5 downto 0) <= data_in(5 downto 0);
  data_out(15 downto 6) <= (15 downto 6 => data_in(5));
  else
  data_out(8 downto 0) <= data_in(8 downto 0 );
  data_out(15 downto 9) <= (15 downto 9 => data_in(8));
  end if;
end process;
end behavioral;