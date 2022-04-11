library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity increment1 is
    port(
        input : in std_logic_vector(15 downto 0);
        reset, clk : in std_logic;
        to_pc : out std_logic_vector(15 downto 0)
    );
end increment1;


architecture Behavioral of increment1 is
  signal r_inc : unsigned(7 downto 0);
  signal r_reg : unsigned(7 downto 0);


begin
  r_inc <= unsigned(input)+1;

  process (clk, reset)
  begin
    if(reset = '1') then
        r_reg <= (others => '0');
    elsif(clk'event and clk = '1') then
        r_reg <= r_inc;
    end if;
  end process;

  to_pc <= std_logic_vector(r_reg);

end Behavioral;