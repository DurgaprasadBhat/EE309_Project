library ieee;
use ieee.std_logic_1164.all;
entity DUT is
   port(input_vector: in std_logic_vector(16 downto 0);
       	output_vector: out std_logic_vector(15 downto 0));
end entity;

architecture DutWrap of DUT is
   component Shifter_7bit is
      generic ( N: integer:=16
  );
    Port ( SHIFTINPUT : in  STD_LOGIC_VECTOR(N-1 downto 0);
   SHIFT_Ctrl : in  STD_LOGIC_VECTOR(0 downto 0); 
   SHIFTOUT: out  STD_LOGIC_VECTOR(N-1 downto 0)
  );
end component;

begin
   add_instance: Shifter_7bit
			Port map ( SHIFTINPUT =>  input_vector(15 downto 0),
					SHIFT_Ctrl => input_vector(16 downto 16), 
					SHIFTOUT => output_vector
				  );
end DutWrap;

