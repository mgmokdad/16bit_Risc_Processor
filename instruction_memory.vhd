--Author: Mohamad EL Mokdad
--Company: Notre Dame University - Louaize
--Description: EEN527 16-bit RIRSC Processor
--Instructor: Dr. Abdallah Kassem
--Date: January 8 2021
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  
-- VHDL code for the Instruction Memory of the MIPS Processor
entity Instruction_Memory_VHDL is
port (
 pc: in std_logic_vector(11 downto 0);
 PC_Out: out std_logic_vector(11 downto 0);
 instruction: out  std_logic_vector(15 downto 0)
);
end Instruction_Memory_VHDL;

architecture Behavioral of Instruction_Memory_VHDL is

 type ROM_type is array (0 to 31 ) of std_logic_vector(15 downto 0);
 
 --Program to be executed:
 
 --ADDI 5, Reg(2)
 --ADDI 8, Reg(3)
 --ADDI 3, Reg(4)
 --ADDI 6, Reg(5)
 --ADD Reg(2), Reg(4)
 --AND Reg(3), Reg(5)
 --CLEAR Reg(3)
 --LD Reg(6), h'01
 --JMP h'02
 constant rom_data: ROM_type:=(
   "0001001000000101",
   "0001001100001000",
   "0001010000000011",
   "0001010100000110",
   "0010000000100100",
   "0101010000110101",
   "0101011000110000",
   "1010011000110001",
   "1100000000000010",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000",
   "0000000000000000"
  );
begin

-- rom_addr <= pc(4 downto 1);
  instruction <= rom_data(to_integer(unsigned(pc)));
  PC_Out<= pc;

end Behavioral;