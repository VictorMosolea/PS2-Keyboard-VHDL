 library IEEE;
use IEEE.std_logic_1164.all;

entity DflipFlop is 
   port(
      Q : out std_logic;    
      clk :in std_logic;  
   sync_reset: in std_logic;  
      D :in  std_logic    
   );
end DflipFlop;

architecture DffArch of DflipFlop is  
begin  
 process(Clk,sync_reset)
 begin 
     if(sync_reset='1') then 
   Q <= '0';
     elsif(falling_edge(clk)) then
   Q <= D; 
  end if;      
 end process;  
end DffArch;	

library IEEE;
use IEEE.std_logic_1164.all; 

entity shiftRegister is 
	generic (n:natural:=33);
	port (
	serial: in std_logic ;
	Clk :in std_logic;
	Q:out std_logic_vector(n-1 downto 0)
	);
end entity;

architecture shiftRegArch of shiftRegister is
signal reg:std_logic_vector (n downto 0) := (others => '1');
component DflipFlop is
	port(
      Q : out std_logic;    
      clk :in std_logic;  
   	  sync_reset: in std_logic;  
      D :in  std_logic    
   );
end component;
begin
	Q<=reg(n-1 downto 0);
	reg(n)<=serial;
shift: for i in n downto 1 generate
	shift_i: DflipFlop port map(reg(i-1),clk,'0',reg(i)); 
end generate shift;
end architecture;
	