--Author: Mohamad EL Mokdad
--Company: Notre Dame University - Louaize
--Description: EEN527 16-bit RIRSC Processor
--Instructor: Dr. Abdallah Kassem
--Date: January 8 2021
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  

entity DEMUX2 is
port (

A, B: out std_logic_vector(7 downto 0);
sel : in std_logic;
input: in std_logic_vector(7 downto 0)
 
);
end DEMUX2;

architecture Behavioral of DEMUX2 is
begin

proc1 : process is
begin

if (sel = '0') then 
	A<=input;
	
end if;

if (sel = '1') then 
	B<=input;
	
end if;
	

end process proc1;

end architecture Behavioral;