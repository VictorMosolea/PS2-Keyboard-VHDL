library IEEE;
use IEEE.std_logic_1164.all;  

entity SevenSegDec is
	port(
	ps2Code: in std_logic_vector(7 downto 0);
	LED:out STD_LOGIC_VECTOR(6 downto 0);
	right:out STD_LOGIC;  
	left:out STD_LOGIC;
	Enter:out STD_LOGIC;
	blink: out STD_LOGIC;
	blinkAlt: out STD_LOGIC;
	esc: out STD_LOGIC;
	alt: out STD_LOGIC
	);
end entity;

architecture SevenSegDecArch of SevenSegDec is	
signal temp:std_logic_vector(6 downto 0);	 
begin
	process(ps2Code,temp) 
	begin
		if ps2Code=x"11" then
			enter<='0';
			left<='0';
			right<='0';
			temp<="0000000"; 
			blink<='0';
			blinkAlt<='0';
			esc<='0';
			alt<='1';
		elsif ps2Code=x"76" then
			enter<='0';
			left<='0';
			right<='0';
			temp<="0000000"; 
			blink<='0';
			blinkAlt<='0';
			esc<='1';
			alt<='0';
		elsif ps2Code=x"78" then
			enter<='0';
			left<='0';
			right<='0';
			temp<="0000000"; 
			blink<='0';
			blinkAlt<='1';
			esc<='0';
			alt<='0';
		elsif ps2Code=x"07" then
			enter<='0';
			left<='0';
			right<='0';
			temp<="0000000"; 
			blink<='1';
			blinkAlt<='0';
			esc<='0';
			alt<='0';
		elsif(ps2Code=x"5A") then
			enter<='1';
			left<='0';
			right<='0';
			temp<="0000000"; 
			blink<='0';
			blinkAlt<='0'; 
			esc<='0';
			alt<='0';
		elsif ps2Code=x"6B" then
			enter<='0';
			left<='1';
			right<='0';
			temp<="0000000";
			blink<='0';
			blinkAlt<='0';
			esc<='0';
			alt<='0';
		elsif ps2Code=x"74" then
			enter<='0';
			left<='0';
			right<='1';
			temp<="0000000";
			blink<='0';
			blinkAlt<='0'; 
			esc<='0';
			alt<='0';
		else	
			case ps2Code is
				when x"1C"=> temp<="1110111";--A 	  
				when x"32"=> temp<="0011111";--b	
				when x"21"=> temp<="1001110";--C	 
				when x"23"=> temp<="0111101";--d 	  
				when x"24"=> temp<="1001111";--E	  
				when x"2B"=> temp<="1000111";--F	  
				when x"34"=> temp<="0011111";--G     
				when x"33"=> temp<="0110111";--H      
				when x"43"=> temp<="0000110";--I     
				when x"3B"=> temp<="0111000";--J
				when x"42"=> temp<="1010111";--K
				when x"4B"=> temp<="0001110";--L
				when x"3A"=> temp<="1010101";--M
				when x"31"=> temp<="1110110";--N
				when x"44"=> temp<="1111110";--O      
				when x"4D"=> temp<="1100111";--P
				when x"15"=> temp<="1110011";--Q
				when x"2D"=> temp<="0000101";--r
				when x"1B"=> temp<="1011011";--S
				when x"2C"=> temp<="0001111";--t
				when x"3C"=> temp<="0111110";--U
				when x"2A"=> temp<="0011100";--V
				when x"1D"=> temp<="0101010";--W
				when x"22"=> temp<="0010100";--X
				when x"35"=> temp<="0111011";--y
				when x"1A"=> temp<="1101100";--Z
				when x"45"=> temp<="1111110";--0 	  
				when x"16"=> temp<="0110000";--1	  
				when x"1E"=> temp<="1101101";--2	  
				when x"26"=> temp<="1111001";--3	  
				when x"25"=> temp<="0010011";--4	  
				when x"2E"=> temp<="1011011";--5 	  
				when x"36"=> temp<="0011111";--6	  
				when x"3D"=> temp<="1110000";--7	  
				when x"3E"=> temp<="1111111";--8	  
				when x"46"=> temp<="1111011";--9     
				when x"29"=> temp<="0000000";--Space
				when others => 	temp<="0000000";
			end case; 
			enter<='0';
			left<='0';
			right<='0';
			blink<='0';	
			blinkAlt<='0';
			esc<='0';
			alt<='0';
		end if;	
			LED<=temp;
	end process;
end architecture;