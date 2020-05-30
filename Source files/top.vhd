library IEEE;
use IEEE.std_logic_1164.all;

entity attempt is
	port(
	ps2_clk :in std_logic;	 
	ps2_data :in std_logic;	
	board_clk:in std_logic;
	LED_OUT: out std_logic_vector(7 downto 0); 
	Anode:out std_logic_vector(3 downto 0)
	);
end entity;	

architecture attemptArch of attempt is	 
signal TC10:std_logic;	
signal Q3:std_logic_vector(0 to 1);
signal ps2word:std_logic_vector(32 downto 0);
signal error:std_logic;		 
signal newCodeFlag:std_logic;
signal refreshClk:std_logic;
signal blinkCLK:std_logic;
signal LED:std_logic_vector(6 downto 0);
signal right:std_logic;	   
signal left:std_logic;
signal enter:std_logic;
signal blink:std_logic;
signal blinkAlt:std_logic;
signal esc:std_logic;
signal alt:std_logic;
component shiftRegister is 
	generic (n:natural:=33);
	port (
	serial: in std_logic ;
	Clk :in std_logic;
	Q:out std_logic_vector(n-1 downto 0)
	);
end component;
component errorDetector is 
generic (n:natural:=33);
   port(
   data:in std_logic_vector(n-1 downto 0); 
   error:out std_logic
   );
end component; 
component counterTo10 is
	port(clk,en,reset :in std_logic;
	TC:out std_logic
	);
end component;
component counterTo3 is
	port( 
	clk :in std_logic;		   
	Q:out std_logic_vector(0 to 1)
	);
end component; 
component newCodeDetector is
	port ( 
	TC10:in std_logic;
	error:in std_logic;
	data:in std_logic_vector(7 downto 0);
	newCodeFlag:out std_logic
	);
end component;	
component SevenSegDec is
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
end component;
component display is
     Port( 
	writeEnable:in STD_LOGIC; 
	Enter:in STD_LOGIC;
	right:in STD_LOGIC;
	left:in STD_LOGIC;
	blink:in STD_LOGIC;
	blinkAlt:in STD_LOGIC;
	blinkCLK:in STD_LOGIC;
	esc:in STD_LOGIC;
	alt:in STD_LOGIC;
	selector : in STD_LOGIC_VECTOR(1 downto 0); 	 
	LED:in STD_LOGIC_VECTOR(6 downto 0);
    Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
    LED_out : out STD_LOGIC_VECTOR (7 downto 0)
	);
end component;
component Clock_Divider is
	port ( clk,reset: in std_logic;
	clock_out: out std_logic);
end component;

component Blink_ClkDivider is
	port ( clk,reset: in std_logic;
	clock_out: out std_logic);
end component;
  
begin	
	C0: Clock_Divider port map(board_clk,'0',refreshClk);
	C1: counterTo10 port map(ps2_clk,'1','0',TC10);
	C2:	shiftRegister port map(ps2_data,ps2_clk,ps2word);
	C3:	errorDetector port map(ps2word,error); 
	C4:	counterTo3 port map(refreshClk,Q3);
	C6: newCodeDetector port map(TC10,error,ps2word(19 downto 12),newCodeFlag);	
	C7: SevenSegDec port map(ps2word(30 downto 23),LED,right,left,enter,blink,blinkAlt,esc,alt);
	C8: display port map(newCodeFlag,enter,right,left,blink,blinkAlt,blinkCLK,esc,alt,Q3,LED,Anode,LED_OUT);
	C9: Blink_ClkDivider port map(board_clk,'0',blinkCLK);
end architecture;