--Author: Mohamad EL Mokdad
--Company: Notre Dame University - Louaize
--Description: EEN527 16-bit RIRSC Processor
--Instructor: Dr. Abdallah Kassem
--Date: January 8 2021
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all;

--------------------------------Entity Declaration------------------------------------------------------------------------------------------------
entity decoder is
  port(clk: in std_logic;
		instruction: in std_logic_vector(15 downto 0);
		PC_Out: in std_logic_vector(11 downto 0);
		zflag: in std_logic;
		RegisterWrite	:	out std_logic;
		BR_Add: out std_logic_vector(11 downto 0);
		BR_Ctrl, EM2Sel, EMSel, EMySel, EMxSel, RegRead, RegWriteD, EMRead, EMWrite, WriteSel, IM: out std_logic;
		OPSel: out std_logic_vector(4 downto 0);
		RxR, RyR, Dest: out std_logic_vector(3 downto 0);
		ImData, EMDAddress: out std_logic_vector(7 downto 0));
     end decoder;
------------------------

architecture decod of decoder is

  begin
 
  
  ----------------Process Declaration-----------------------------------  
  wrr: process(clk,instruction) is
  begin
  
  if(clk'event and clk='1') then
  
	case instruction(15 downto 12) is
	
	when  "0000" =>          -- No Operation
         BR_Add <= "000000000000";
		 BR_Ctrl <= '0';
		 OPSel <="00000";
		 Dest<="0000";
		 EM2Sel <='0';
		 EMSel <='0';
		 EMySel <='0'; EMxSel <='0'; RegRead <='0'; RegWriteD <='0'; EMRead <='0'; EMWrite <='0'; WriteSel <= '0';
		 RxR<="0000";RyR<="0000"; Dest <="0000";
		 ImData <="00000000";
		 EMDAddress <="00000000";
		  RegisterWrite<='Z';
		 
		 	 
    when "0001" =>
		RxR <= instruction(11 downto 8);
          ImData <= instruction(7 downto 0);
		  IM<='1';
          RyR<="0000";
		  OPSel<="ZZZZZ";
		  BR_Add<= "000000000000";
		  BR_Ctrl<= '0';
		  RegWriteD<='1';
		  RegRead<='0';
		  WriteSel<='0';
		  Dest<="0000";
		  EMRead<= '0';
		  EMWrite<= '0';
		  EM2Sel<= '0';
		  EMSel<= '0';
		  EMySel<= '0';
		  EMxSel<='0';
		  EMDAddress<="00000000";
		    RegisterWrite<='Z';
		  
		  when "0010" =>
          RxR <= instruction(7 downto 4);
          RyR <= instruction(3 downto 0);
          ImData<="00000000";
		  BR_Add<= "000000000000";
		  BR_Ctrl<= '0';
		  RegWriteD<='Z';
		  RegRead<='1';
		  WriteSel<='1';
		  Dest<=instruction(7 downto 4);
		  EMRead<='0';
		  EMWrite<= '0';
		  EM2Sel<= '1';
		  EMSel<='Z';
		  EMySel<='0';
		  EMxSel<='0';
		  EMDAddress<="00000000";
		    RegisterWrite<='Z';
          if(instruction (11 downto 8) = "0000") then
           OPSel<= "00001";
          elsif(instruction(11 downto 8) = "0001") then
           OPSel <= "00010";  --subtraction
          end if;
		  
		  when "0011" =>
          RxR <= instruction(7 downto 4);
          RyR <= instruction(3 downto 0);
          ImData<="00000000";
		  BR_Add<= "000000000000";
		  BR_Ctrl<= '0';
		  RegWriteD<='Z';
		  RegRead<='1';
		  WriteSel<='1';
		   EMDAddress<="00000000";
		  Dest<=instruction(7 downto 4);
		  EMRead<= '0';
		  EMWrite<= '0';
		  EM2Sel<= '1';
		  EMSel<='Z';
		  EMySel<= '0';
		  EMxSel<='0';
		    RegisterWrite<='Z';
          if(instruction (11 downto 8) = "0000") then
           OPSel<= "00011";
          elsif(instruction(11 downto 8) = "0001") then
           OPSel <= "00100";  --subtraction
          end if;
		 
		 
		 when "0100" =>
          RxR <= instruction(7 downto 4);
          RyR <= instruction(3 downto 0);
          ImData<="00000000";
		  BR_Add<= "000000000000";
		  BR_Ctrl<= '0';
		  RegWriteD<='Z';
		  RegRead<='1';
		  RegisterWrite<='Z';
		  WriteSel<='1';
		   EMDAddress<="00000000";
		  Dest<=instruction(7 downto 4);
		  EMRead<='0';
		  EMWrite<= '0';
		  EM2Sel<= '1';
		  EMSel<='Z';
		  EMySel<='0';
		  EMxSel<='0';
          if(instruction(11 downto 8) = "0000") then
           OPSel <= "00101";  --shift left
          elsif(instruction(11 downto 8) = "0001") then
           OPSel <= "00110";  --shift right
          end if;
		  
		  
		  when "0101" =>
          RxR <= instruction(7 downto 4);
          RyR <= instruction(3 downto 0);
          ImData<="00000000";
		  BR_Add<= "000000000000";
		  BR_Ctrl<= '0';
		  RegWriteD<='Z';
		   EMDAddress<="00000000";
		  RegRead<='1';
		  WriteSel<='1';
		  Dest<=instruction(7 downto 4);
		  EMRead<= '0';
		  EMWrite<= '0';
		  RegisterWrite<='Z';
		  EM2Sel<= '1';
		  EMSel<='Z';
		  EMySel<= '0';
		  EMxSel<='0';
          if(instruction(11 downto 8) = "0000") then
           OPSel <= "00111";  --not rx
          elsif(instruction(11 downto 8) = "0001") then
           OPSel <= "01000";  --nor rx , ry
          elsif(instruction(11 downto 8) = "0010") then
           OPSel <= "01001";   -- nand rx, ry
          elsif(instruction(11 downto 8) = "0011") then
           OPSel <= "01010";   -- xor rx, ry
          elsif(instruction(11 downto 8) = "0100") then
           OPSel <= "01011";   -- and rx, ry
          elsif(instruction(11 downto 8) = "0101") then
           OPSel <= "01100";   -- or rx, ry
          elsif(instruction(11 downto 8) = "0110") then
           OPSel <= "01101";   -- clr rx
          elsif(instruction(11 downto 8) = "0111") then
           OPSel <= "01110";   -- set rx
          elsif(instruction(11 downto 8) = "1111") then
           OPSel <= "01111";   -- set if less than
		   
		   elsif(instruction(11 downto 8) = "1001") then
           OPSel <= "10000";   -- reset if  less than
           
           elsif(instruction(11 downto 8) = "1000") then
           OPSel <= "10001";   -- Mov
            
          end if;
		  
		  when "1000" =>
		  EMRead<='1';
		  EMWrite<='0';
		  OPSel<="10010";
		  EM2Sel<='0';
		  EMSel<='1';
		  RegisterWrite<='Z';
		  EMySel<='1';
		  EMDAddress<="ZZZZZZZZ";
		  EMxSel<='Z';
		  Dest<=instruction(7 downto 4);
		  RyR<=instruction(3 downto 0);
		  RxR<="ZZZZ";
		  WriteSel<='1';
		  RegRead<='0';
		  RegWriteD<='1';
		  
		    when "1001" =>
        EMRead<='0';
		  EMWrite<='1';
		  OPSel<="10011";
		  EM2Sel<='Z';
		  EMSel<='1';
		  EMySel<='1';
		  
		   EMDAddress<="ZZZZZZZZ";
		  EMxSel<='1';
		  Dest<="0000";
		  RyR<=instruction(3 downto 0);
		  RxR<=instruction(7 downto 4);
		  WriteSel<='1';
		  RegRead<='1';
		  RegWriteD<='0';
		  RegisterWrite<='1';
		  
		 when "1010" =>
		  EMRead<='1';
		  EMWrite<='0';
		  OPSel<="10100";
		  EM2Sel<='0';
		  RegisterWrite<='Z';
		  EMSel<='0';
		  EMySel<='Z';
		  EMDAddress<=instruction(7 downto 0);
		  EMxSel<='Z';
		  Dest<=instruction(11 downto 8);
		  RyR<="ZZZZ";
		  RxR<="ZZZZ";
		  WriteSel<='0';
		  RegRead<='0';
		  RegWriteD<='1';
		  
		   when "1011" =>
          EMRead<='0';
		  EMWrite<='1';
		  OPSel<="10101";
		  EM2Sel<='Z';
		  EMSel<='0';
		  EMySel<='Z';
		  EMDAddress<=instruction(7 downto 0);
		  EMxSel<='1';
		  Dest<="ZZZZ";
		  RyR<="ZZZZ";
		  RxR<=instruction(11 downto 8);
		  WriteSel<='1';
		  RegRead<='1';
		  RegWriteD<='0';
		  RegisterWrite<='1';
		  
		  when "1100" =>
          EMRead<='Z';
		  EMWrite<='Z';
		  OPSel<="ZZZZZ";
		  EM2Sel<='Z';
		  EMSel<='Z';
		  EMySel<='Z';
		  EMDAddress<="ZZZZZZZZ";
		  EMxSel<='Z';
		  Dest<="ZZZZ";
		  RyR<="ZZZZ";
		  RxR<="ZZZZ";
		  RegisterWrite<='Z';
		  WriteSel<='Z';
		  RegRead<='Z';
		  RegWriteD<='Z';
		  BR_Ctrl<='1';
		  BR_Add<=instruction(11 downto 0);
		  
		  when "1101" =>
		   EMRead<='Z';
		  EMWrite<='Z';
		  OPSel<="ZZZZZ";
		  EM2Sel<='Z';
		  EMSel<='Z';
		  EMySel<='Z';
		  EMDAddress<="ZZZZZZZZ";
		  EMxSel<='Z';
		  Dest<="ZZZZ";
		  RyR<="ZZZZ";
		  RxR<="ZZZZ";
		  WriteSel<='Z';
		  RegisterWrite<='Z';
		  RegRead<='Z';
		  RegWriteD<='Z';
		  if zflag = '1' then
			BR_Ctrl<='1';
			BR_Add <= PC_Out + instruction(11 downto 0);
			end if;
			
			when "1110" =>
		   EMRead<='Z';
		  EMWrite<='Z';
		  OPSel<="ZZZZZ";
		  EM2Sel<='Z';
		  EMSel<='Z';
		  RegisterWrite<='Z';
		  EMySel<='Z';
		  EMDAddress<="ZZZZZZZZ";
		  EMxSel<='Z';
		  Dest<="ZZZZ";
		  RyR<="ZZZZ";
		  RxR<="ZZZZ";
		  WriteSel<='Z';
		  RegRead<='Z';
		  RegWriteD<='Z';
		  if zflag = '0' then
			BR_Ctrl<='1';
			BR_Add <= PC_Out + instruction(11 downto 0);
			end if;
		  
		 
		 
	when others =>
      null;
	
	end case;
  
  end if;
  
  end process wrr;
  
  end architecture decod;