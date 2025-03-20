library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flipflop is
port(
    clk   : in std_logic;
    d     : in unsigned(7 downto 0);
    reset : in std_logic;
    q     : out unsigned(7 downto 0)
);
end flipflop;

architecture arch of flipflop is
signal q_reg: unsigned(7 downto 0) := (others => '0');
begin

process(clk, reset)
begin
    if (reset = '1') then
        q_reg <= (others => '0');  -- Reset value
    elsif rising_edge(clk) then
        q_reg <= d;  -- Store new value on rising edge
    end if;
end process;

q <= q_reg; -- Output

end arch;
