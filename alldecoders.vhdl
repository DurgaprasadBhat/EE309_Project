library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Dmux is
port ( Ra : in std_logic_vector(2 downto 0);
		 Rc : in std_logic_vector(2 downto 0);
		 SR : in std_logic_vector(2 downto 0);
		 DS : in std_logic_vector(1 downto 0);
		 D : out std_logic_vector(2 downto 0)
		 );
end Dmux;		 
architecture dmuxarch of Dmux is 
begin
	process(Ra, Rc, SR, DS)
	begin
	case(DS) is
	when "00" => D <= Ra;
	when "01" => D <= Rc;
	when "10" => D <= SR;
	when "11" => D <= "111";
	end case;
	end process;
end dmuxarch;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AS2mux is 
port ( Ra : in std_logic_vector(2 downto 0);
		 Rb : in std_logic_vector(2 downto 0);
		 as2 : in std_logic_vector(1 downto 0);
		 output: out std_logic_vector(2 downto 0)	
		);
end AS2mux;		
architecture as2muxarch of AS2mux is
begin
	process(Ra,Rb,as2)
	begin
	case(as2) is
		when "00" => output <= Ra;
		when "01" => output <= Rb;
		when "10" => output <= "111";
	end case;
	end process;
end as2muxarch;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AS1mux is 
port ( Ra : in std_logic_vector(2 downto 0);
		 SR : in std_logic_vector(2 downto 0);
		 as1 : in std_logic_vector(1 downto 0);
		 output: out std_logic_vector(2 downto 0)	
		);
end AS1mux;		
architecture as1muxarch of AS1mux is
begin
	process(Ra,SR,as1)
	begin
	case(as1) is
		when "00" => output <= Ra;
		when "01" => output <= SR;
		when "10" => output <= "111";
	end case;
	end process;
end as1muxarch;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
port (cy, z, s0, s1  : in std_logic; output: out std_logic);
end mux;
	
architecture muxarch of mux is
begin
process(s0, s1, cy, z)
begin 
if(s0 = '0' and s1 ='0') then
	output <= '1';
elsif(s0 = '1' and s1 ='0') then
	output <= z;
elsif(s0 = '0' and s1 ='1') then
	output <= cy;
else 
	output <= '1';
end if;
end muxarch;
	
