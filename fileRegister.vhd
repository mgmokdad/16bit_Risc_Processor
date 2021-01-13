--Author: Mohamad EL Mokdad
--Company: Notre Dame University - Louaize
--Description: EEN527 16-bit RIRSC Processor
--Instructor: Dr. Abdallah Kassem
--Date: January 8 2021
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all;

entity file_register is
port (
 clk, rst, RegRead,RegWrite, IM: in std_logic;
 RxR, RyR, DestReg: in std_logic_vector(3 downto 0);
 ImData, result : in std_logic_vector (7 downto 0);
 RxD, RyD: out std_logic_vector(7 downto 0));
end file_register;

architecture Behavioral of file_register is

 type ROM_type is array (0 to 15 ) of std_logic_vector(7 downto 0);
 signal rom_data: ROM_type:=(
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000"
 
  );
begin

proc1 : process(clk, rst, RegRead, RegWrite, IM) is
begin

if ( rst='1') then
	rom_data<=("00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000",
   "00000000"
 
  );
  
  end if;
  
if (clk'event and clk ='1') then

	if (RegRead = '1') then 
		RxD<=rom_data(conv_integer(RxR));
		RyD<=rom_data(conv_integer(RyR));
		
		end if;
		
	if (RegWrite = '1') then
		rom_data(conv_integer(DestReg))<=result;
		
		end if;
		
	if (IM ='1') then
		rom_data(conv_integer(DestReg))<=ImData;
		
		end if;
		

end if;
	



end  process proc1;

end  architecture Behavioral;