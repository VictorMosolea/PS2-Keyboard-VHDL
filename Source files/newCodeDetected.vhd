library IEEE;
use IEEE.std_logic_1164.all;
entity newCodeDetector is
	port ( 
	TC10:in std_logic;
	error:in std_logic;
	data:in std_logic_vector(7 downto 0);
	newCodeFlag:out std_logic
	);
end entity;

architecture newCodeDetectorArch of newCodeDetector is
begin
	process(TC10, data, error)  
	begin
	if(TC10='1' and data=x"F0" and error ='0') then
		newCodeFlag<='1';
	else newCodeFlag<='0';
	end if;					
	end process;
end architecture;
	
	