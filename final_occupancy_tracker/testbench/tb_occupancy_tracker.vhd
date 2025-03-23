library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_occupancy_tracker is
end tb_occupancy_tracker;

architecture Behavioral of tb_occupancy_tracker is

    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '1';
    signal entry_sensor : STD_LOGIC := '0';
    signal exit_sensor : STD_LOGIC := '0';
    signal max_occupancy : UNSIGNED(7 downto 0) := to_unsigned(10, 8);
    signal max_capacity : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.occupancy_tracker
        port map (
            clk => clk,
            rst => rst,
            entry_sensor => entry_sensor,
            exit_sensor => exit_sensor,
            max_occupancy => max_occupancy,
            max_capacity => max_capacity
        );

    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the system
        wait for 20 ns;
        rst <= '0';

        -- Test case 1: Normal operation
        for i in 1 to 5 loop
            wait for 10 ns;
            entry_sensor <= '1';
            wait for 10 ns;
            entry_sensor <= '0';
        end loop;

        -- Test case 2: Exit operation
        for i in 1 to 3 loop
            wait for 10 ns;
            exit_sensor <= '1';
            wait for 10 ns;
            exit_sensor <= '0';
        end loop;

        -- Test case 3: Max capacity
        for i in 1 to 10 loop
            wait for 10 ns;
            entry_sensor <= '1';
            wait for 10 ns;
            entry_sensor <= '0';
        end loop;

        -- Test case 4: Reset
        wait for 20 ns;
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        -- Finish simulation
        wait for 100 ns;
        wait;
    end process;

end Behavioral;
