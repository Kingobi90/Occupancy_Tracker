library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reset_unit is
port(
    clk : in std_logic;
    reset : in std_logic;
    reset_out : out std_logic
);
end reset_unit;

architecture arch of reset_unit is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            reset_out <= reset;
        end if;
    end process;
end arch;
