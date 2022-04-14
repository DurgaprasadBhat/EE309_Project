library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
port(instruction:in std_logic_vector(15 downto 0);
        reset,clock:in std_logic; IB, SB: in integer; c, z, sr, b : in std_logic; 
        cont_word: out std_logic);
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
        when 1=>
				y_next<= 2;
        when 2=>
				y_next<= IB;
        when 3=>
				y_next<= SB;
		  when 4 =>
		      y_next <= 5;
		  when 5 =>
		      y_next <= IB;
		  when 6 =>
		      y_next <= 0;
		  when 7 =>
		      y_next <= 0;
		  when 8 =>
		      if (z = '1') then
		      y_next <= 9;
				else 
				y_next <= 11;
				end if;
		  when 9 =>
		      y_next <= 10;
		  when 10 =>
		      y_next <= 0;
		  when 11 =>
		      y_next <= SB;
		  when 12 =>
		      y_next <= SB;
		  when 13 =>
		      y_next <= 14;
		  when 14 =>
		      y_next <= 0;
		  when 15 =>
		      y_next <= SB;
		  when 16 =>
		      y_next <= IB;
		  when 17 =>
		      y_next <= 18;
		  when 18 =>
		      if (sr = '0') then
		      y_next <= 0;
            elsif (sr = '1' and b = '0') then
				y_next <= 19;
				else 
				y_next <= SB;
				end if;
		  when 19 =>
		      y_next <= 17;
		  when 20 =>
		      y_next <= 18;
		  
    end case;
end process;

end rch;

		          
                