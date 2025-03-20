library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity monitor_tb is
end monitor_tb;

architecture test of monitor_tb is

    -- Component declaration for the unit under test (UUT)
    component monitor
    port(
        clk : in std_logic;
        reset : in std_logic;
        x, y : in std_logic;
        max_occupancy : in unsigned(7 downto 0);
        r : out unsigned(7 downto 0);
        z : out std_logic
    );
    end component;

    -- Test signals
    signal clk       : std_logic := '0';
    signal reset     : std_logic := '0';
    signal x         : std_logic := '0';
    signal y         : std_logic := '0';
    signal max_occupancy : unsigned(7 downto 0) := "00000100";  -- Max capacity = 4
    signal r         : unsigned(7 downto 0);
    signal z         : std_logic;

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the monitor component
    UUT: monitor port map(
        clk => clk,
        reset => reset,
        x => x,
        y => y,
        max_occupancy => max_occupancy,
        r => r,
        z => z
    );

    -- Clock process
    clk_process: process
    begin
        while now < 200 ns loop  -- Run simulation for 200 ns
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus: process
    begin
        -- 1. Apply Reset
        report "Test Start: Applying reset";
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 10 ns;
        
        -- 2. People entering the room (increment occupancy)
        report "Testing Entry: Expecting r = 1, 2, 3...";
        x <= '1'; y <= '0'; wait for clk_period;  -- r = 1
        x <= '1'; y <= '0'; wait for clk_period;  -- r = 2
        x <= '1'; y <= '0'; wait for clk_period;  -- r = 3
        x <= '1'; y <= '0'; wait for clk_period;  -- r = 4 (Max occupancy reached)
        x <= '1'; y <= '0'; wait for clk_period;  -- Should NOT increment (r stays 4)

        -- 3. Check max capacity signal
        report "Max capacity reached. Checking z = 1";
        assert z = '1' report "Error: Max capacity signal incorrect" severity error;
        
        -- 4. People leaving the room (decrement occupancy)
        report "Testing Exit: Expecting r = 3, 2, 1, 0...";
        x <= '0'; y <= '1'; wait for clk_period;  -- r = 3
        x <= '0'; y <= '1'; wait for clk_period;  -- r = 2
        x <= '0'; y <= '1'; wait for clk_period;  -- r = 1
        x <= '0'; y <= '1'; wait for clk_period;  -- r = 0
        x <= '0'; y <= '1'; wait for clk_period;  -- Should NOT decrement (r stays 0)

        -- 5. Apply Reset again
        report "Applying Reset Again: Expecting r = 0";
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for clk_period;

        -- 6. Simulation End
        report "Test Completed Successfully!";
        wait;
    end process;

end test;
