library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity occupancy_tracker is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        entry_sensor : in STD_LOGIC;
        exit_sensor : in STD_LOGIC;
        max_occupancy : in UNSIGNED(7 downto 0);
        max_capacity : out STD_LOGIC
    );
end occupancy_tracker;

architecture Behavioral of occupancy_tracker is
    signal current_occupancy : UNSIGNED(7 downto 0) := (others => '0');
begin

    process(clk, rst)
    begin
        if rst = '1' then
            current_occupancy <= (others => '0');
            max_capacity <= '0';
        elsif rising_edge(clk) then
            -- Handle entry
            if entry_sensor = '1' and current_occupancy < max_occupancy then
                current_occupancy <= current_occupancy + 1;
            end if;

            -- Handle exit
            if exit_sensor = '1' and current_occupancy > 0 then
                current_occupancy <= current_occupancy - 1;
            end if;

            -- Update max capacity status
            if current_occupancy >= max_occupancy then
                max_capacity <= '1';
            else
                max_capacity <= '0';
            end if;
        end if;
    end process;

end Behavioral;
