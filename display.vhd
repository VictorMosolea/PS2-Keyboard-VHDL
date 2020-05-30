library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity display is
    Port( 
	writeEnable:in STD_LOGIC; 
	Enter:in STD_LOGIC;
	right:in STD_LOGIC;
	left:in STD_LOGIC;
	blink:in STD_LOGIC;
	blinkAlt:in STD_LOGIC;
	blinkCLK:in STD_LOGIC;
	esc:in STD_LOGIC;
	alt: in STD_LOGIC;
	selector : in STD_LOGIC_VECTOR(1 downto 0); 	 
	LED:in STD_LOGIC_VECTOR(6 downto 0);
    Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
    LED_out : out STD_LOGIC_VECTOR (7 downto 0)
	);
end display;

architecture displayArch of display is
signal displayed_number: STD_LOGIC_VECTOR (31 downto 0);
signal temp: STD_LOGIC_VECTOR(7 downto 0); 	
begin	
	process(writeEnable, right, left, LED, enter, displayed_number,blink,blinkAlt) 
	begin  
		if(rising_edge(writeEnable)) then
			if(Enter='0' and right='0' and left='0' and blink='0' and blinkAlt='0' and alt='0' and esc='0') then
							displayed_number(31 downto 25)<=displayed_number(23 downto 17);
							displayed_number(23 downto 17)<=displayed_number(15 downto 9);		
							displayed_number(15 downto 9)<=displayed_number(7 downto 1); 
							displayed_number(7 downto 1)<=LED;
			elsif alt='1' then
				displayed_number(31 downto 25)<="0000000";
				displayed_number(23 downto 17)<="1110111";
				displayed_number(15 downto 9)<="0001110";
				displayed_number(7 downto 1)<="0001111";
			elsif esc='1' then
				displayed_number(31 downto 25)<="0000000";
				displayed_number(23 downto 17)<="1001001";
				displayed_number(15 downto 9)<="1011011";
				displayed_number(7 downto 1)<="1001110";
			elsif(Enter='1') then
				displayed_number<=x"00000000";
			elsif(right='1') then
					if(displayed_number(24)='1') then 
						displayed_number(16)<='1';
						displayed_number(24)<='0';
						displayed_number(8)<='0';
						displayed_number(0)<='0';
					elsif(displayed_number(16)='1') then 
						displayed_number(8)<='1';
						displayed_number(24)<='0';
						displayed_number(16)<='0';
						displayed_number(0)<='0';
					elsif(displayed_number(8)='1') then 
						displayed_number(0)<='1';
						displayed_number(24)<='0';
						displayed_number(16)<='0';
						displayed_number(8)<='0';
					else 
						displayed_number(0)<='0';
						displayed_number(24)<='1';
						displayed_number(16)<='0';
						displayed_number(8)<='0';
					end if;
			elsif(left='1') then
					if(displayed_number(24)='1') then 
						displayed_number(16)<='0';
						displayed_number(24)<='0';
						displayed_number(8)<='0';
						displayed_number(0)<='1';
					elsif(displayed_number(16)='1') then 
						displayed_number(8)<='0';
						displayed_number(24)<='1';
						displayed_number(16)<='0';
						displayed_number(0)<='0';
					elsif(displayed_number(8)='1') then 
						displayed_number(0)<='0';
						displayed_number(24)<='0';
						displayed_number(16)<='1';
						displayed_number(8)<='0';
					else 
						displayed_number(0)<='1';
						displayed_number(24)<='0';
						displayed_number(16)<='0';
						displayed_number(8)<='0';  
					end if;
				end if;		
			else for i in 0 to 31 loop
				if displayed_number(i)='U' then
					displayed_number(i)<='0';
				end if;	
				end loop;
		end if;
	end process;
	process(selector,displayed_number,blink,blinkAlt,blinkCLK)
	begin
		 case selector is
				    	when "00" =>
						  Anode_Activate <= "0111"; 
				      when "01" =>
				        Anode_Activate <= "1011"; 
				      when "10" =>
				        Anode_Activate <= "1101"; 
				      when others =>
				        Anode_Activate <= "1110"; 
				        
				end case;
		 if(blink='1' and blinkCLK='0') then
				temp<=x"FF";
		 elsif(blinkAlt='1') then
			  case selector is
				    	when "00" =>
						 	if(blinkCLK='1') then
				        		temp <= not displayed_number(31 downto 24);
							else
								temp<=x"FF";
							end if;	
				    	when "01" =>
				  			if(blinkCLK='0') then
				        		temp <= not displayed_number(23 downto 16);
							else
								temp<=x"FF";
							end if;	
				    	when "10" =>
				      		 if(blinkCLK='1') then
				        		temp <= not displayed_number(15 downto 8);
							else
								temp<=x"FF";
							end if;
				    	when others =>
				         	if(blinkCLK='0') then
				        		temp <= not displayed_number(7 downto 0);
							else
								temp<=x"FF";
							end if;
						end case;	
			else 
				case selector is
				    	when "00" =>
						 
				        temp <= not displayed_number(31 downto 24); 
				    	when "01" =>
				  
				        temp <= not displayed_number(23 downto 16);
				    	when "10" =>
				      
				        temp <= not displayed_number(15 downto 8);
				    	when others =>
				         
				        temp <= not displayed_number(7 downto 0);  
				end case;
		end if;		
	end process;
	LED_OUT<=temp;
end displayArch;
