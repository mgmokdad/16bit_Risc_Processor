--Author: Mohamad EL Mokdad
--Company: Notre Dame University - Louaize
--Description: EEN527 16-bit RIRSC Processor
--Instructor: Dr. Abdallah Kassem
--Date: January 8 2021
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  

entity MUX1 is
port (

A, B: in std_logic;
sel : in std_logic;
output: out std_logic
 
);
end MUX1;

architecture Behavioral of MUX1 is
begin

proc1 : process is
begin

if (sel = '0') then 
	output<=A;
	
end if;

if (sel = '1') then 
	output<=B;
	
end if;
	

end process proc1;

end architecture Behavioral;