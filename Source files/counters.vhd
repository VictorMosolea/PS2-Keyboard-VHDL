library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_unsigned.all;

entity counterTo10 is
	port(clk,en,reset :in std_logic;
	TC:out std_logic
	);
end entity;

architecture counterTo10Arch of counterTo10 is
signal t:natural;
begin		  
	process(en,clk,reset)
	begin
		if reset='1'then t<=0;
			
		else 
			if en='0' then t<=t;
				elsif clk='1' and clk'event then
					if t=10 then t<=0;
					else t<=t+1;
					end if;
					if(t=10) then TC<='1';
						else TC<='0';
					end if;
			end if;
		end if;
	end process;
end architecture;

library IEEE;
use IEEE.std_logic_1164.all; 	 
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counterTo3 is
	port(
	clk :in std_logic;		   
	Q:out std_logic_vector(0 to 1)
	);
end entity;

architecture counterTo3Arch of counterTo3 is
signal t:natural;
begin
	process(clk,t)
	begin
	if(clk='0' and clk'event) then
			if(t=3) then
				t<=0;
			else t<=t+1;
			end if;
		end if;
		case t is
			when 0=> Q<="00";
			when 1=> Q<="01";
			when 2=> Q<="10";
			when 3=> Q<="11";
			when others=> Q<="00"; 		 
		end case;	
	end process;
end architecture;			
