library ieee;
use ieee.std_logic_1164.all;
entity Mux4a is
	port( a3, a2, a1, a0 : in std_logic; 
	s : in std_logic_vector(1 downto 0); -- one-hot select
	b : out std_logic );
end Mux4a;
architecture case_impl of Mux4a is
begin
process(all) begin
case s is
when "00" => b <= a0;
when "01" => b <= a1;
when "10" => b <= a2;
when "11" => b <= a3;
end case;
end process;
end case_impl;