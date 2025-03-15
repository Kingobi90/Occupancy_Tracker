library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity project is
	port( x,y : in std_logic;
		m : in unsigned (7 downto 0);
		maxCapacity: out std_logic;
		rest : in std_logic;
		clk: in std_logic);
end project;


architecture project_arch of project is
	signal qX,qY : std_logic;

	signal occupancyCount : unsigned(7 downto 0);
	
	signal maxCapacityT : std_logic := '0';
	
	component flipflop
		port( clk : in std_logic;
	      	      d   : in std_logic;
	     	      q   : out std_logic);
	end component;

	component reset
		port( clk: in std_logic;
	      	    reset: in std_logic;
	     	     q   : out std_logic);
	end component;

begin

flipflopX : flipflop port map(clk => clk, d => x, q => qX);
flipflopY : flipflop port map(clk => clk, d => y, q => qY);


process(clk)
begin
	if rising_edge(clk) then
		if rest = '1' then
			occupancyCount <= (others => '0');
		elsif qX = '1' then
			occupancyCount <= occupancyCount + 1;
		elsif qY = '1' then
			occupancyCount <= occupancyCount - 1;
		end if;
	end if;
end process;

process(occupancyCount, m)
begin 
	if occupancyCount >= m then
		maxCapacityT <= '1';
	else
		maxCapacityT <= '0';
	end if;
end process;

maxCapacity <= maxCapacityT;

resetComponent : reset port map(clk => clk, reset => rest);
end project_arch;
