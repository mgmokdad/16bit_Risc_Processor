--Author: Mohamad EL Mokdad
--Company: Notre Dame University - Louaize
--Description: EEN527 16-bit RIRSC Processor
--Instructor: Dr. Abdallah Kassem
--Date: January 8 2021
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all;

--------------Entity Declaration---------------------
entity program_counter is
	port( 	
		clk : in std_logic;
		rst: in std_logic; 
		BR_Address : in std_logic_vector(11 downto 0);  
		BR_Ctrl : in std_logic;
		PC	: out std_logic_vector(11 downto 0));

end program_counter;
----------------------------------------------------

--------------Architecture Body Declaration-------------
architecture counter of program_counter is

begin   --architecture begins here

------Process declaration-----------------------  
pc1: process(clk, rst, BR_Ctrl)
variable pc_1 : std_logic_vector(11 downto 0) := "000000000000";
variable pc_2 : std_logic_vector(11 downto 0) := "000000000000";
variable a : std_logic := '1';
begin     --process begins here

if (clk'event and clk='1') then
 
    if (rst = '1') then
		pc_1 := (others => '0');
    end if; 
   
    if (BR_Ctrl = '1') then
		pc_2 := BR_Address;
		a := '1'; 
    end if ;

    
    if (a = '1') then
    pc_1 := pc_2 ;
    a := '0';
     
    else
    pc_1 := pc_1 + "000000000001";
    end if ;
    
    PC <= pc_1 ;    

    end if; 

    
  end process pc1;
----------------------------------------------------

end counter;      --architecture ends here
     
  		
