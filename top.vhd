--Author: Mohamad EL Mokdad
--Company: Notre Dame University - Louaize
--Description: EEN527 16-bit RIRSC Processor
--Instructor: Dr. Abdallah Kassem
--Date: January 8 2021
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all;


------------------------ Entity Declaration---------------------
entity top is
	port ( 
		clk: in std_logic;
		rst: in std_logic);
end top; 


architecture rtl of top is 

signal pc_1 :  std_logic_vector(11 downto 0);
signal instruction_1: std_logic_vector(15 downto 0);
signal PC_Out_1: std_logic_vector(11 downto 0);
signal BR_Ctrl_1 : std_logic;
signal BR_Add_1 : std_logic_vector(11 downto 0);
signal EMRead_1 : std_logic;
signal EMWrite_1 : std_logic;
signal OPSel_1 : std_logic_vector(4 downto 0);
signal EM2Sel_1 : std_logic;
signal EMSel_1 : std_logic;
signal Dest_1 : std_logic_vector(3 downto 0);
signal EMySel_1 : std_logic;
signal EMxSel_1 : std_logic;
signal EMDAddress_1 : std_logic_vector(7 downto 0);
signal IM_1 : std_logic;
signal RxR_1 : std_logic_vector(3 downto 0);
signal RyR_1 : std_logic_vector(3 downto 0);
signal IMData_1 : std_logic_vector(7 downto 0);
signal WriteSel_1 : std_logic;
signal RegRead_1 : std_logic;
signal RegWriteD_1 : std_logic;
signal RegWrite_1 : std_logic;
signal Result_1	: std_logic_vector(7 downto 0);
signal DestReg_1: std_logic_vector(3 downto 0);
signal RxD_1: std_logic_vector(7 downto 0);
signal RyD_1: std_logic_vector(7 downto 0);
signal RegWriteA_1: std_logic;
signal ALUResult_1: std_logic_vector(7 downto 0);
signal RyData_1: std_logic_vector(7 downto 0);
signal RxData_1: std_logic_vector(7 downto 0);
signal RegisterWrite_1: std_logic;
signal ZFlag_1: std_logic;
signal EMOutput_1: std_logic_vector(7 downto 0);
signal EMAddress_1: std_logic_vector(7 downto 0);
signal RegisterData_1: std_logic_vector(7 downto 0);
signal tmp_1: std_logic_vector(7 downto 0);


component program_counter is
	port( 	
		clk : in std_logic;
		rst: in std_logic; 
		BR_Address : in std_logic_vector(11 downto 0);  
		BR_Ctrl : in std_logic;
		PC	: out std_logic_vector(11 downto 0));

end  component program_counter;

component Instruction_Memory_VHDL is
port (
 pc: in std_logic_vector(11 downto 0);
 PC_Out: out std_logic_vector(11 downto 0);
 instruction: out  std_logic_vector(15 downto 0)
);
end  component Instruction_Memory_VHDL;

component decoder is
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
     end component decoder;
	 
component file_register is
port (
 clk, rst, RegRead,RegWrite, IM: in std_logic;
 RxR, RyR, DestReg: in std_logic_vector(3 downto 0);
 ImData, result : in std_logic_vector (7 downto 0);
 RxD, RyD: out std_logic_vector(7 downto 0));
end component file_register;

component DEMUX1 is
port (

A, B: out std_logic_vector(7 downto 0);
sel : in std_logic;
input: in std_logic_vector(7 downto 0)
 
);
end component DEMUX1;

component DEMUX2 is
port (

A, B: out std_logic_vector(7 downto 0);
sel : in std_logic;
input: in std_logic_vector(7 downto 0)
 
);
end component DEMUX2;

component alu1 is 
	port(
	
	clk: in std_logic;
	OPSel: in std_logic_vector(4 downto 0);
	ZFlag: out std_logic;
	Dest: in std_logic_vector(3 downto 0);
	RegWriteA: out std_logic;
	RxData, RyData : in std_logic_vector(7 downto 0 );
	DestReg : out std_logic_vector(3 downto 0);
	AluResult: out std_logic_vector(7 downto 0));
	
	end component alu1;
	
component data_memory_vhdl is
port (
 clk, rst, EMRead,EMWrite, RegisterWrite: in std_logic;
 EMOutput : out std_logic_vector(7 downto 0);
 EMAddress, RegisterData : in std_logic_vector(7 downto 0));
end component data_memory_vhdl;

component MUX1 is
port (

A, B: in std_logic;
sel : in std_logic;
output: out std_logic
 
);
end component MUX1;

component MUX2 is
port (

A, B: in std_logic_vector(7 downto 0);
sel : in std_logic;
output: out std_logic_vector(7 downto 0)
 
);
end component MUX2;

component MUX3 is
port (

A, B: in std_logic_vector(7 downto 0);
sel : in std_logic;
output: out std_logic_vector(7 downto 0)
 
);
end component MUX3;



begin


p_c : program_counter port map(clk, rst, BR_Add_1, BR_Ctrl_1, pc_1);

i_m : Instruction_Memory_VHDL port map(pc_1, PC_Out_1, instruction_1);

i_d	: decoder port map(clk, instruction_1, PC_Out_1, ZFlag_1,RegisterWrite_1, BR_Add_1, BR_Ctrl_1, EM2Sel_1, EMSel_1, EMySel_1, EMxSel_1, RegRead_1, RegWriteD_1, EMRead_1, EMWrite_1, WriteSel_1, IM_1, OPSel_1, RxR_1, RyR_1, Dest_1, IMData_1, EMDAddress_1);

mx_1 : MUX1 port map(RegWriteD_1, RegWriteA_1, WriteSel_1, RegWrite_1);

mx_2 : MUX2 port map(EMOutput_1,ALUResult_1, EM2Sel_1, Result_1);

mx_3 : MUX3 port map(EMDAddress_1, tmp_1, EMSel_1, EMAddress_1);

dmx_1 : DEMUX1 port map(RxData_1, RegisterData_1, EMxSel_1, RxD_1);

dmx_2 : DEMUX2 port map(RxData_1, RegisterData_1, EMxSel_1, RxD_1);

al_u : alu1 port map(clk, OPSel_1,ZFlag_1,Dest_1,RegWriteA_1,RxData_1, RyData_1,DestReg_1, ALUResult_1);

f_g : file_register port map(clk, rst, RegRead_1, RegWrite_1,IM_1,RxR_1, RyR_1,DestReg_1, IMData_1, Result_1, RxD_1, RyD_1);

d_m : data_memory_vhdl port map(clk, rst, EMRead_1, EMWrite_1, RegisterWrite_1, EMOutput_1,EMAddress_1, RegisterData_1);




end architecture rtl;