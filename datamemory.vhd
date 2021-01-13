--Author: Mohamad EL Mokdad
--Company: Notre Dame University - Louaize
--Description: EEN527 16-bit RIRSC Processor
--Instructor: Dr. Abdallah Kassem
--Date: January 8 2021
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all;

entity data_memory_vhdl is
port (
 clk, rst, EMRead,EMWrite, RegisterWrite: in std_logic;
 EMOutput : out std_logic_vector(7 downto 0);
 EMAddress, RegisterData : in std_logic_vector(7 downto 0));
end data_memory_vhdl;

architecture Behavioral of data_memory_vhdl is

 type ROM_type is array (0 to 15 ) of std_logic_vector(7 downto 0);
 
 
 signal rom_data: ROM_type:=(
   "00000000",
   "01011111",
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

proc1 : process is
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
	if (EMRead = '1') then
		EMOutput<=rom_data(conv_integer(EMAddress));
		
	end if;
	
	if (EMWrite = '1') then
			
		if (RegisterWrite = '1') then
			rom_data(conv_integer(EMAddress))<=RegisterData;
			
		end if;
		
	end if;

	
		

end if;
	



end  process proc1;

end  architecture Behavioral;