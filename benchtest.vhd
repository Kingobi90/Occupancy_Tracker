 library IEEE;
 use IEEE.std_logic_1164.all;
 --use IEEE.std_logic_arith.all;
 use IEEE.std_logic_unsigned.all;
 use IEEE.numeric_std.all;

 ENTITY gen_monitor IS

 BEGIN

 END gen_monitor;

 ARCHITECTURE arch of gen_monitor IS

 CONSTANT max_simulation_time : TIME := 240 ns;
 CONSTANT clk_period          : TIME := 10 ns;

COMPONENT monitor is
port(
clk : in std_logic;
reset : in std_logic;
x,y : in std_logic;
max_occupancy : in unsigned(5 downto 0);
r: out unsigned(5 downto 0);
z : out std_logic
);
end COMPONENT;

 SIGNAL my_clk, my_reset   : STD_LOGIC;
 SIGNAL my_X, my_Y : STD_LOGIC;
 SIGNAL my_max_occupancy : UNSIGNED(5 DOWNTO 0);
 SIGNAL my_r: unsigned(5 downto 0);
 SIGNAL my_z : STD_LOGIC;

 -- Components specification
 FOR monitor_inst: monitor USE ENTITY work.monitor(arch);


 BEGIN

  clk_gen: PROCESS
     VARIABLE sim_time : TIME;
   BEGIN
       sim_time := 0 ns;
       WHILE sim_time <=  max_simulation_time LOOP
          my_clk <= '0';
          WAIT FOR 5 ns;
          my_clk <= '1';
          WAIT FOR 5 ns;
          sim_time := sim_time + clk_period;
       END LOOP;
       WAIT;
    END PROCESS;

monitor_inst: monitor PORT MAP (my_clk, my_reset, my_X, my_Y, my_max_occupancy, my_r, my_z);

   gen_stimuli: PROCESS

   BEGIN
      -- set max occupancy to 4
        my_max_occupancy <= "000100";

      --reset
 	
      WAIT  UNTIL  my_clk'event AND my_clk = '0' ;
        my_reset <= '1';

       WAIT UNTIL  my_clk'event AND my_clk = '0' ;
        my_reset <= '0';

       -- make 4 people walk in;
       WAIT  UNTIL my_clk'event AND my_clk = '0' ;
        my_X <= '1';
 	my_Y <= '0';
       WAIT  UNTIL my_clk'event AND my_clk = '1' ;
        my_X <= '0';
 	my_Y <= '0';
 	  


       WAIT  UNTIL my_clk'event AND my_clk = '0' ;
        my_X <= '1';
 	my_Y <= '0';

       WAIT  UNTIL my_clk'event AND my_clk = '1' ;
        my_X <= '0';
 	my_Y <= '0';


       WAIT  UNTIL my_clk'event AND my_clk = '0' ;
        my_X <= '1';
 	my_Y <= '0';

       WAIT  UNTIL my_clk'event AND my_clk = '1' ;
        my_X <= '0';
 	my_Y <= '0';


       WAIT  UNTIL my_clk'event AND my_clk = '0' ;
        my_X <= '1';
 	my_Y <= '0';

       WAIT  UNTIL my_clk'event AND my_clk = '1' ;
        my_X <= '0';
 	my_Y <= '0';


       -- make all 4 people walk out

       WAIT  UNTIL my_clk'event AND my_clk = '0' ;
        my_X <= '0';
 	my_Y <= '1';

       WAIT  UNTIL my_clk'event AND my_clk = '1' ;
        my_X <= '0';
 	my_Y <= '0';
 	  


       WAIT  UNTIL my_clk'event AND my_clk = '0' ;
        my_X <= '0';
 	my_Y <= '1';

       WAIT  UNTIL my_clk'event AND my_clk = '1' ;
        my_X <= '0';
 	my_Y <= '0';



       WAIT  UNTIL my_clk'event AND my_clk = '0' ;
        my_X <= '0';
 	my_Y <= '1';

       WAIT  UNTIL my_clk'event AND my_clk = '1' ;
        my_X <= '0';
 	my_Y <= '0';



       WAIT  UNTIL my_clk'event AND my_clk = '0' ;
        my_X <= '0';
 	my_Y <= '1';

       WAIT  UNTIL my_clk'event AND my_clk = '1' ;
        my_X <= '0';
 	my_Y <= '0';


   END PROCESS;


 END arch;



	

