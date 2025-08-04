library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity latch_1 is
    Port ( 
	     clock, reset : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR (7 downto 0);
		   Q : out STD_LOGIC_VECTOR (7 downto 0)
    );
end latch_1;

architecture Behavior of latch_1 is
begin
    process(reset, clock)
    begin
        if reset = '0' then
            Q <= (others => '0');
        elsif rising_edge(clock) then
            Q <= data_in;
        end if;
    end process;
end Behavior;

