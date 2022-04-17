library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
port(instruction:in std_logic_vector(15 downto 0);
        reset,clock:in std_logic; IB, SB: in integer; c, z, b : in std_logic; 
		  sr : in std_logic_vector(2 downto 0);
        cont_word: out std_logic_vector(19 downto 0));
end controller;

architecture rch of controller is

---------------Define state type here-----------------------------
--type state is (init,s1,s2,s3,s4); -- Fill the code
---------------Define signals of state type-----------------------
signal y_present,y_next: integer := 31;

begin
clock_proc:process(clock,reset)
begin
    if(clock='1' and clock' event) then
        if(reset='1') then
            y_present <= 31 ; -- Fill the code
        else
            y_present <= y_next;-- Fill the code
        end if;
    end if;
    
end process;

state_transition_proc:process(instruction,y_present)
begin
    y_next <= y_present;
    case y_present is
        when 0=>
				y_next<= IB;
				cont_word <= "00100000000010000101";
        when 1=>
				y_next<= 2;
				cont_word <= "01010001101110000001";
        when 2=>
				y_next<= IB;
				cont_word <= "00110000100010100101";
        when 3=>
				y_next<= SB;
				cont_word <= "10010011101010000001";
		  when 4 =>
		      y_next <= 5;
				cont_word <= "00100000000000000101";
		  when 5 =>
		      y_next <= IB;
				cont_word <= "00100000100010000101";
		  when 6 =>
		      y_next <= 0;
				cont_word <= "00101000000100010001";
		  when 7 =>
		      y_next <= 0;
				cont_word <= "00100100100000000001";
		  when 8 =>
		      cont_word <= "11101000001110000001";
		      if (z = '1') then
		      y_next <= 9;
				else 
				y_next <= 11;
				end if;
		  when 9 =>
		      y_next <= 10;
				cont_word <= "00010110010010000001";
		  when 10 =>
		      y_next <= 0;
				cont_word <= "00110000100001100001";
		  when 11 =>
		      y_next <= SB;
				cont_word <= "00100001100000000001";
		  when 12 =>
		      y_next <= SB;
				cont_word <= "00010111110010000001";
		  when 13 =>
		      y_next <= 14;
				cont_word <= "00010111110010000001";
		  when 14 =>
		      y_next <= 0;
				cont_word <= "00101000100100000001";
		  when 15 =>
		      y_next <= SB;
				cont_word <= "00001000011010000001";

		  when 16 =>
		      y_next <= IB;
				cont_word <= "00100000100100000001";
		  when 17 =>
		      y_next <= 18;
				cont_word <= "00011000000000001010";
		  when 18 =>
		      cont_word <= ""; 
		      if (sr = "000") then
		      y_next <= 0;
            elsif (sr /= "000" and b = '0') then
				y_next <= 19;
				else 
				y_next <= SB;
				end if;
		  when 19 =>
		      y_next <= 17;
				cont_word <= "00101000000000000001";
		  when 20 =>
		      y_next <= 18;
		      cont_word <= "00011000001101000010";
    end case;
end process;

end rch;

		          
                