library IEEE;
use IEEE.std_logic_1164.all; 

entity errorDetector is 
generic (n:natural:=33);
   port(
   data:in std_logic_vector(n-1 downto 0); 
   error:out std_logic
   );
end errorDetector; 

architecture errorDetectorArch of errorDetector is  
begin  
 process(data)
 begin 
   error<= NOT (NOT data(0) AND data(10) AND (data(9) XOR data(8) XOR
        data(7) XOR data(6) XOR data(5) XOR data(4) XOR data(3) XOR 
        data(2) XOR data(1)))
		OR NOT (NOT data(11) AND data(21) AND (data(20) XOR data(19) XOR
        data(18) XOR data(17) XOR data(16) XOR data(15) XOR data(14) XOR 
        data(13) XOR data(12))) 
		OR NOT (NOT data(22) AND data(32) AND (data(31) XOR data(30) XOR
        data(29) XOR data(28) XOR data(27) XOR data(26) XOR data(25) XOR 
        data(24) XOR data(23)));       
 end process;  
end errorDetectorArch;	
