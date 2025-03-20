library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity monitor is
port(
    clk : in std_logic;
    reset : in std_logic;
    x, y : in std_logic;  -- Entry and Exit signals
    max_occupancy : in unsigned(7 downto 0);  -- 8-bit threshold
    r : out unsigned(7 downto 0);  -- Current occupancy count
    z : out std_logic  -- max_capacity signal
);
end monitor;

architecture arch of monitor is

-- Signals
signal r_next: unsigned(7 downto 0);
signal r_reg: unsigned(7 downto 0);
signal reset_signal: std_logic;

-- Component Declarations
component flipflop
port(
    clk   : in std_logic;
    d     : in unsigned(7 downto 0);
    reset : in std_logic;
    q     : out unsigned(7 downto 0)
);
end component;

component reset_unit
port(
    clk : in std_logic;
    reset : in std_logic;
    reset_out : out std_logic
);
end component;

begin

-- Reset Logic Component
RESET_CTRL: reset_unit port map(
    clk => clk,
    reset => reset,
    reset_out => reset_signal
);

-- Flip-Flop Component for Occupancy Count
FF: flipflop port map(
    clk => clk,
    d => r_next,
    reset => reset_signal,
    q => r_reg
);

-- Occupancy Calculation Logic
process(x, y, r_reg, max_occupancy)
begin
    r_next := r_reg;  -- Default: Keep the same value

    -- If person enters and room isn't full
    if (x = '1' and y = '0' and r_reg < max_occupancy) then
        r_next := r_reg + 1;
    -- If person exits and room isn't empty
    elsif (x = '0' and y = '1' and r_reg > 0) then
        r_next := r_reg - 1;
    end if;
end process;

-- Output Assignments
r <= r_reg;
z <= '1' when r_reg = max_occupancy else '0';  -- Assert max_capacity when full

end arch;
