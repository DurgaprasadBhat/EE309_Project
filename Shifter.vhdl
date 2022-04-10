library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;


entity shifter_7bit is
  generic ( N: integer:=16
  );
    Port ( SHIFTINPUT : in  STD_LOGIC_VECTOR(N-1 downto 0);
   SHIFT_Ctrl : in  STD_LOGIC_VECTOR(0 downto 0); 
   SHIFTOUT: out  STD_LOGIC_VECTOR(N-1 downto 0)
  );
end shifter_7bit;

architecture shift7b of shifter_7bit is

begin
process(SHIFTINPUT,SHIFT_Ctrl)
begin
case(SHIFT_Ctrl) is



when "0" => SHIFTOUT <= SHIFTINPUT;
when "1" => SHIFTOUT <= SHIFTINPUT(8 downto 0) & "0000000";
end case;
end process;

end shift7b;




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;



entity shifter_1bit is
  generic ( N: integer:=16
  );
    Port ( SHIFTINPUT : in  STD_LOGIC_VECTOR(N-1 downto 0);
   SHIFT_Ctrl : in  STD_LOGIC_VECTOR(0 downto 0); 
   SHIFTOUT: out  STD_LOGIC_VECTOR(N-1 downto 0)
  );
end shifter_1bit;

architecture shift1b of shifter_1bit is

begin
process(SHIFTINPUT,SHIFT_Ctrl)
begin
case(SHIFT_Ctrl) is



when "0" => SHIFTOUT <= SHIFTINPUT;
when "1" => SHIFTOUT <= SHIFTINPUT(14 downto 0) & "0";
end case;
end process;

end shift1b;

