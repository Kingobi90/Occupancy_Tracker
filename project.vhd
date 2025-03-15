library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity project is
    port( 
        x, y  : in std_logic;
        m     : in unsigned(7 downto 0);
        maxCapacity : out std_logic;
        rest  : in std_logic;
        clk   : in std_logic
    );
end project;

architecture project_arch of project is
    signal qX, qY : std_logic;
    signal occupancyCount : unsigned(7 downto 0) := (others => '0');
    signal maxCapacityT : std_logic := '0';

    -- Flip-Flop Component for Synchronization
    component flipflop
        port( 
            clk : in std_logic;
            d   : in std_logic;
            q   : out std_logic
        );
    end component;

begin

-- D Flip-Flops to Synchronize Inputs
flipflopX : flipflop port map(clk => clk, d => x, q => qX);
flipflopY : flipflop port map(clk => clk, d => y, q => qY);

-- Process to Handle Occupancy Count and Max Capacity
process(clk)
begin
    if rising_edge(clk) then
        if rest = '1' then
            occupancyCount <= (others => '0'); -- Reset occupancy count
            maxCapacityT <= '0'; -- Ensure reset removes max capacity restriction
        elsif (qX = '1' and occupancyCount < m) then
            occupancyCount <= occupancyCount + 1; -- Increment if below max
        elsif (qY = '1' and occupancyCount > 0) then
            occupancyCount <= occupancyCount - 1; -- Decrement if above 0
        end if;

        -- Update max capacity status
        if occupancyCount = m then
            maxCapacityT <= '1'; -- Room is full
        elsif occupancyCount < m then
            maxCapacityT <= '0'; -- Space is available
        end if;
    end if;
end process;

maxCapacity <= maxCapacityT;

end project_arch;
