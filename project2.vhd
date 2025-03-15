library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity project2 is
  port (
    X            : in  STD_LOGIC;
    Y            : in  STD_LOGIC;
    m            : in  unsigned(7 downto 0);
    reset        : in  STD_LOGIC;  
    max_capacity : out  STD_LOGIC;
    current_count: out  unsigned(7 downto 0)
  );
end entity project2;

architecture project2Architecture of project2 is
  signal count : unsigned(7 downto 0) := (others => '0');
  signal internal_current_count : unsigned(7 downto 0) := (others => '0');
 
begin

  process(X, Y, reset, count)
  begin
    if reset = '1' then
      internal_current_count <= (others => '0');
    elsif X = '1' and count < m then
      internal_current_count <= internal_current_count + 1;
    elsif Y = '1' and internal_current_count > 0 then
      internal_current_count <= internal_current_count - 1;
    end if;
  end process;

  max_capacity <= '1' when internal_current_count > m else '0';
  current_count <= internal_current_count;
end architecture project2Architecture;
