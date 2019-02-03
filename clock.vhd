library ieee;
      use ieee.std_logic_1164.all;
entity clock is
         port(
		-- slide switches	
		sw : in std_logic_vector(1 downto 0);  

		-- 7-segment display
		--hex0-1-2 : out std_logic_vector(6 downto 0);
		-- Key-0
		key : in std_logic;
		key1 : in std_logic;
		-- LED-0
		HEX0 : out std_logic_vector(6 downto 0);
		HEX1 : out std_logic_vector(6 downto 0);
		HEX2 : out std_logic_vector(6 downto 0);
		HEX3 : out std_logic_vector(6 downto 0);
		HEX4 : out std_logic_vector(6 downto 0);
		HEX5 : out std_logic_vector(6 downto 0);
				-- clk
		max10_clk1_50 : in std_logic
		
	); 
	end clock;
	architecture struct of clock is
	      signal clksec:std_logic;
         signal clkmin:std_logic;
         signal clkhour:std_logic;
	      signal clksec1:std_logic;
         signal clkmin1:std_logic;
         signal clkhour1:std_logic;
			signal clkday:std_logic;
			signal hours:std_logic_vector(5 downto 0);
			signal minutes:std_logic_vector(5 downto 0);
			signal seconds:std_logic_vector(5 downto 0);
			signal bcd0:std_logic_vector(3 downto 0);
			signal bcd1:std_logic_vector(3 downto 0);
			signal bcd2:std_logic_vector(3 downto 0);
			signal bcd3:std_logic_vector(3 downto 0);
			signal bcd4:std_logic_vector(3 downto 0);
			signal bcd5:std_logic_vector(3 downto 0);
	component counter is
			generic( n: integer := 49999999 );
          Port( clk : in std_logic;
                reset : in std_logic;
                clko : out std_logic);
		end component;
	component counter2 is
			generic( n: integer := 49999999 );
          Port( clk : in std_logic;
                clko : out std_logic;
					 counted: out std_logic_vector(5 downto 0));
		end component;
	component sigtobcd is
	port(
		sig : in std_logic_vector(5 downto 0);  
		bcdout1 : out std_logic_vector(3 downto 0);
		bcdout2 : out std_logic_vector(3 downto 0));
		end component;
	component ssg
      port (s : in std_logic_vector(3 downto 0);hexout : out std_logic_vector(6 downto 0));
	end component;
				component Mux4a
      port (a3, a2, a1, a0 : in std_logic;	s : in std_logic_vector(1 downto 0); -- one-hot select
	b : out std_logic );
   end component;
	begin
		  sec:counter generic map(49999999) port map(max10_clk1_50,KEY,clksec1);
        min:counter2 generic map(59) port map(clksec,clkmin1,seconds);
        hour:counter2 generic map(59) port map(clkmin,clkhour1,minutes);
        day:counter2 generic map(23) port map(clkhour,clkday,hours);
		  sig2bcdsec: sigtobcd port map(seconds, bcd0, bcd1);
		  sig2bcdmin: sigtobcd port map(minutes, bcd2, bcd3);
		  sig2bcdhour: sigtobcd port map(hours, bcd4, bcd5);
		  ssg1: ssg port map(bcd0, hex0);
		  ssg2: ssg port map(bcd1, hex1);
		  ssg3: ssg port map(bcd2, hex2);
		  ssg4: ssg port map(bcd3, hex3);
		  ssg5: ssg port map(bcd4, hex4);
		  ssg6: ssg port map(bcd5, hex5);
		  v1:Mux4a port map(key and clkhour1,(not key),key and clkhour1,key and clkhour1,SW(1 downto 0),clkhour);
		  v2:Mux4a port map(key and clkmin1,key and clkmin1,(not key),key and clkmin1,SW(1 downto 0),clkmin);
		  v3:Mux4a port map((not key),key and clksec1,key and clksec1,key and clksec1,SW(1 downto 0),clksec);
	end struct;