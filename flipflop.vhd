library ieee;
use ieee.std_logic_1164.all;

entity flipflop is 
port(
	clk : in std_logic;
	d   : in std_logic;
	q   : out std_logic);
end flipflop;

architecture synchronous of flipflop is
signal qInt : std_logic := '0';
begin
process(clk)
	begin
		if rising_edge(clk) then
			qInt <= d;
		end if;
	end process;
	
	q <= qInt;
end synchronous;
