library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;


entity shifter_7bit is -- 7 bit shifter for instruction of type I
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



when "0" => SHIFTOUT <= SHIFTINPUT; -- do nothing
when "1" => SHIFTOUT <= SHIFTINPUT(8 downto 0) & "0000000"; --shift 7 bits
end case;
end process;

end shift7b;




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;



entity shifter_1bit is -- 1 bit shifter for instruction ADL
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



when "0" => SHIFTOUT <= SHIFTINPUT;  --do nothing
when "1" => SHIFTOUT <= SHIFTINPUT(14 downto 0) & "0"; --shift 1 bit
end case;
end process;

end shift1b;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;


entity shifter_8bit is
  generic ( N: integer:=16
  );
    Port ( SHIFTINPUT : in  STD_LOGIC_VECTOR(N-1 downto 0);
   SHIFT_Ctrl : in  STD_LOGIC_VECTOR(0 downto 0); 
   SHIFTOUT: out  STD_LOGIC_VECTOR(N-1 downto 0)
  );
end shifter_8bit;

architecture shift8b of shifter_8bit is

begin
process(SHIFTINPUT,SHIFT_Ctrl)
begin
case(SHIFT_Ctrl) is



when "0" => SHIFTOUT <= SHIFTINPUT;  -- do nothing
when "1" => SHIFTOUT <= SHIFTINPUT(7 downto 0) & "00000000"; --shift 8 bits
end case;
end process;

end shift8b;