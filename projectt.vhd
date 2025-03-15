library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity monitor is
port(
clk : in std_logic;
reset : in std_logic;
x,y : in std_logic;
max_occupancy : in unsigned(5 downto 0);
r: out unsigned(5 downto 0);
z : out std_logic
);
end monitor;

architecture arch of monitor is


signal sel: std_logic_vector(1 downto 0);
signal r_reg: INTEGER range 0 to 63:= 0;
signal r_next:INTEGER range 0 to 63:= 0;
begin

process(clk,reset)
begin 
if (reset = '1') then
r_reg <= 0;
elsif (clk'event and clk = '1') then 
r_reg <= r_next;
end if;
end process;

sel <= x & y;

process(sel)
begin
if(sel="10" and r_reg < max_occupancy) then
r_next <= r_reg + 1;
elsif(sel="01" and r_reg > 0) then
r_next <= r_reg - 1;
end if;
end process;

r <= to_unsigned(r_reg,6);
z <= '1' when r_reg = max_occupancy else
'0';
end arch;
