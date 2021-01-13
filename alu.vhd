--Author: Mohamad EL Mokdad
--Company: Notre Dame University - Louaize
--Description: EEN527 16-bit RIRSC Processor
--Instructor: Dr. Abdallah Kassem
--Date: January 8 2021
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all;
use ieee.numeric_std.all; 

entity alu1 is 
	port(
	
	clk: in std_logic;
	OPSel: in std_logic_vector(4 downto 0);
	ZFlag: out std_logic;
	Dest: in std_logic_vector(3 downto 0);
	RegWriteA: out std_logic;
	RxData, RyData : in std_logic_vector(7 downto 0 );
	DestReg : out std_logic_vector(3 downto 0);
	AluResult: out std_logic_vector(7 downto 0));
	
	end alu1;
	
architecture rtl of alu1 is 
begin

proc1 : process(clk) is

variable tmp1 : std_logic_vector(7 downto 0):= "00000000";
variable tmp2 : std_logic_vector(7 downto 0):= "00000000";
variable result : std_logic_vector(7 downto 0):= "00000000";
begin
if(clk'event and clk='0') then

case OPSel is 

when "00000" =>
	result:="00000000";
	RegWriteA<='Z';
	ZFlag<='Z';
	DestReg<="ZZZZ";
	
when "00001" =>
	tmp1 := RxData;
	tmp2 := RyData;
	result:=tmp1+tmp2;
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;

when "00010" =>
	tmp1 := RxData;
	tmp2 := RyData;
	result:=tmp1-tmp2;
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "00011" =>
	tmp1 := RxData;
	tmp2 := RyData;
	result:=tmp1+"00000001";
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "00100" =>
	tmp1 := RxData;
	tmp2 := RyData;
	result:=tmp1-"00000001";
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "00101" =>
	tmp1 := RxData;
	tmp2 := RyData;
	result:=to_stdlogicvector(to_bitvector(tmp1) sll Conv_Integer(tmp2));
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "00110" =>
	tmp1 := RxData;
	tmp2 := RyData;
	result:=to_stdlogicvector(to_bitvector(tmp1) srl Conv_Integer(tmp2));
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "00111" =>
	tmp1 := RxData;
	tmp2 := RyData;
	result:=not tmp1;
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "01000" =>
	tmp1 := RxData;
	tmp2 := RyData;
	result:=tmp2 nor tmp1;
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "01001" =>
	tmp1 := RxData;
	tmp2 := RyData;
	result:=tmp1 nand tmp2;
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "01010" =>
	tmp1 := RxData;
	tmp2 := RyData;
	result:=tmp1 xor tmp2;
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "01011" =>
	tmp1 := RxData;
	tmp2 := RyData;
	result:=tmp1 and tmp2;
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "01100" =>
	tmp1 := RxData;
	tmp2 := RyData;
	result:=tmp1 or tmp2;
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "01101" =>
	
	result:="00000000";
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "01110" =>
	
	result:="11111111";
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "01111" =>
	tmp1 := RxData;
	tmp2 := RyData;
	
	if (tmp1<tmp2) then	
		result:="11111111";
		
	else 
		result:=tmp1;
		
	end if;
	
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "10000" =>
	tmp1 := RxData;
	tmp2 := RyData;
	
	if (tmp1<tmp2) then	
		result:="00000000";
		
	else 
		result:=tmp1;
		
	end if;
	
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "10001" =>

	tmp1 := RxData;
	tmp2 := RyData;
	AluResult<=tmp2;
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "10010" =>
	AluResult<="ZZZZZZZZ";
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
	
when "10011" =>
	AluResult<="ZZZZZZZZ";
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;

when "10100" =>
	AluResult<="ZZZZZZZZ";
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<=Dest;
		
when "10101" =>
	AluResult<="ZZZZZZZZ";
	RegWriteA<='1';
	ZFlag<='Z';
	DestReg<="ZZZZ";
	

when others =>
      null;
	
	end case;
	
if result="00000000" then
	ZFlag<='1';
	
	else
		ZFlag<='0';
	

end if;

AluResult<=result;
	


end if;

end process proc1;

end architecture rtl;
	
	
	
