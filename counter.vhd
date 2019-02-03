 library ieee;
      use ieee.std_logic_1164.all;
      use ieee.std_logic_arith.all;
		use IEEE.std_logic_unsigned.all;
      -- This is the entity part.  It describes the inputs and the outputs
       

      entity counter is
		    generic( n: integer := 49999999 ); -- counts
          Port ( clk : in std_logic;
              reset : in std_logic;
              clko : out std_logic
				  );
      end counter ;

      architecture behavioural of counter is
		begin	 
   process(clk)
        variable cnt:std_logic_vector(26 downto 0);
   begin
         if(clk'event and clk='1') then
			--synchronous reset
             if(reset='0')then
                 cnt:=(others=>'0');
                 clko<='0';
             else
                 if(cnt=n) then
                     cnt:=(others=>'0');
                     clko<='1';
                  else
                     cnt:=cnt+1;
                     clko<='0';
                  end if;
             end if;
        end if;
   end process; 
      end behavioural;