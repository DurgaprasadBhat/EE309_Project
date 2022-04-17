LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.all;

entity datapath is
	port(clk: in std_logic
		  );
end datapath;

architecture mjolnir of datapath is
	signal RFtob16, T1tob16: std_logic_vector(15 downto 0);
	signal en_T1b, en_RFb: std_logic;
	signal busA, busB : std_logic_vector(15 downto 0);
	signal outA,outB,inputA,inputB,incr,to_inc: std_logic_vector(15 downto 0);
	signal writeEnable1,inc_wr_en,b_wr_en: std_logic;
	signal regASel, regBSel, writeRegSel : std_logic_vector(2 downto 0);
	signal alu_inp1, alu_inp2, alu_out : std_logic_vector(15 downto 0);
	signal alu_opcode : std_logic_vector(1 downto 0);
	signal carryF, zeroF,zero_out : std_logic;
	signal control_word : std_logic_vector(19 downto 0);
	signal rst, cont_C, cont_Z, ctrl_SR, b : std_logic;
	signal IB, SB : integer;
	signal SE_di, SE_do: std_logic_vector(15 downto 0);
	signal SE_sel : std_logic_vector(0  downto 0);
	signal SR_inp_inc : std_logic_vector(15 downto 0);
	signal SR_wr_en : std_logic;
	signal SR_out : std_logic_vector(2 downto 0);
	signal inc_in, inc_out: std_logic_vector(15 downto 0);
	signal shift_in_7,shift_out_7,shift_in_8,shift_out_8,shift_in_1,shift_out_1 : std_logic_vector(15 downto 0);
	signal shift_ctrl_7,shift_ctrl_8,shift_ctrl_1 : std_logic_vector(0 downto 0);
	signal T1_inp_b, T1_inp_alu, T1_inp_inc, T1_out : std_logic_vector(15 downto 0);
	signal T1_en_b, T1_en_alu, T1_en_inc : std_logic;
	signal inc_sel : std_logic_vector(1 downto 0);
	signal IR_in, IR_out, IR_L_out: std_logic_vector(15 downto 0);
	signal IR_en : std_logic;
	signal ram_out : std_logic_vector(15 downto 0) := x"0000";
	signal T1_decoded: std_logic_vector(4 downto 0);
	signal ir_decoded: std_logic_vector(2 downto 0);
	signal regFD: std_logic_vector(10 downto 0);
	signal Ra, Rb, Rc : std_logic_vector(2 downto 0);
	signal PC: std_logic_vector(2 downto 0) := "111";
        signal ctrl1, ctrl0, cz_ctrl,reg_file_wr_a : std_logic ;
	begin
	        reg_file_wr_a <= cz_ctrl and regFD(10);
		
		a16: work.a16 generic map(16) 
						  port map(in_DI => ram_out, in_RFa => outA, in_IR => shift_out_7,
									  in_T1 => T1_out, en_DI => control_word(3), en_T1 => T1_decoded(0), en_IR=> ir_decoded(0), 
									  en_RFa =>regFD(3),
									  q =>  busA);
									  
		b16: work.b16 port map(IN_RF_b=>outB,IN_t1 => T1_out , 
									  en_T1=> T1_decoded(1),en_RF_b=> regFD(2),
									  q => busB);
									  
	   RF: work.register_file port map(outA => outA, outB => outB, inputA => inputA, inputB => inputB, 
												  incr => incr, to_inc => to_inc,writeEnable1=>reg_file_wr_a,
												  inc_wr_en=>regFD(8),b_wr_en=> regFD(9), regASel => regASel,
												  regBSel => regBSel, writeRegSel => writeRegSel, clk => clk
												  );
												  
		ALU: work.ALU port map(INPUT1 =>busA, INPUT2=>shift_out_1, OP=>alu_opcode, sel=>control_word(19 downto 18),
									  CY => carryF, Z => zeroF, Z_out => zero_out , OUTPUT => alu_out);	
									  
		Ctrl: work.controller port map(reset => rst, clock=>clk, 
												  IB => IB, SB => SB,c=> carryF ,z=> zero_out ,
												  sr =>	SR_out , b => b, cont_word =>control_word
												);
											
		SE : work.SEXT5_0 port map(data_in=>IR_out,data_out=>shift_in_7, sel =>ir_decoded(2 downto 2));
		
		SR : work.SR port map(inp_inc=>inc_out,wr_en=> SR_wr_en, clk => clk, output => SR_out);
		
		shifter7: work.shifter_7bit port map(SHIFTINPUT=>shift_in_7,SHIFT_Ctrl=> ir_decoded(1 downto 1),
														 SHIFTOUT => shift_out_7);
	 
	   shifter1: work.shifter_1bit port map( SHIFTINPUT=>busB, SHIFT_Ctrl => shift_ctrl_1,
														 SHIFTOUT => shift_out_1);
														
		T1: work.T1 port map(inp_b16=>busB ,b16_wr_en=> T1_decoded(4),inp_inc=> inc_out,
									inc_wr_en=>T1_decoded(3),inp_alu=> alu_out,alu_wr_en=> T1_decoded(2),
									clk => clk, output => T1_out);
									
									 	
	   Incr1: work.increment1 port map(t1=>T1_out, pc=>to_inc, sr=>SR_out,sel=> control_word(1 downto 0),
												output => inc_out);
		
		
		
		IR : work.IR port map(d=>ram_out,en=> control_word(2), clk => clk, q => IR_out);
			
	        IR_L : work.IR_L port map(d => ram_out, ld => control_word(2), q => IR_L_out);
		
		shift_ctrl_1(0) <= (IR_out(0) and IR_out(1)) and ((not IR_out(15)) and (not IR_out(14)) and (not IR_out(13)) and IR_out(12));
		
		Ra <= IR_out(11 downto 9);
		Rb <= IR_out(8 downto 6);
		Rc <= IR_out(5 downto 3);
		
		InstDec : work.InstDec port map(instruction => IR_L_out, IB => IB, SB => SB);
		
		RAM : work.Single_Port_RAM_VHDL port map( RAM_ADDR=>busB, RAM_DATA_IN=>busA, RAM_WR=>control_word(4),
																RAM_CLOCK =>clk,
																RAM_DATA_OUT => ram_out);	
																
		B1 : work.BBBB port map(SRin=> SR_out, IRin=>IR_out, b => b);	


		T1dec: work.T1_dec port map(inp=>control_word(17 downto 15), output => T1_decoded);	
		
		ir_dec1: work.IRdec port map(inp=>control_word(14 downto 13), output => ir_decoded);
		
		
		regFileDec: work.regFileDec port map(inp=>control_word(12 downto 5), output => regFD); 
		
		
		dmux: work.Dmux port map(Ra => Ra, Rc=> Rc, SR => SR_out, DS=> regFD(1 downto 0), D=>writeRegSel);
		
		as2mux : work.AS2mux port map( Ra => Ra, Rb => Rb,as2 => regFD(5 downto 4), output => regBSel); 
		
		as1mux : work.AS1mux port map( Ra => Ra, SR => SR_out,as1 => regFD(6 downto 5), output => regASel); 
		
		alu_mux : work.mux port map(cy => carryF, z => zeroF, s1 => ctrl1 , s0 => ctrl0, output => cz_ctrl);
		
	        ctrl1 <= ((not IR_out(15)) and (not IR_out(14) and (not IR_out(13))and IR_out(12) or (not IR_out(15)) and (not IR_out(14) and (IR_out(13))and ( not IR_out(12)) )IR_out(1);
		ctrl0 <= ((not IR_out(15)) and (not IR_out(14) and (not IR_out(13))and IR_out(12) or (not IR_out(15)) and (not IR_out(14) and (IR_out(13))and ( not IR_out(12)) )IR_out(0);
		
		
end mjolnir;
