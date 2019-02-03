 library ieee;
      use ieee.std_logic_1164.all;
		use ieee.numeric_std.all;

      -- This is the entity part.  It describes the inputs and the outputs
       

      entity sigtobcd is
         port(
		-- signal in	
		sig : in std_logic_vector(5 downto 0);  

		-- 7-segment display
		bcdout1 : out std_logic_vector(3 downto 0);
		bcdout2 : out std_logic_vector(3 downto 0)
		
	);  
      end sigtobcd ;

      architecture behavioural of sigtobcd is
		begin	 
		  process(sig)
		  variable b,c,d: integer;
		  begin
				b:=to_integer(unsigned(sig));
				c:= b mod 10;
				d:=(b-c)/10;
				bcdout1<=std_logic_vector(to_unsigned(c,4));
				bcdout2<=std_logic_vector(to_unsigned(d,4));
		  end process;
      end behavioural;