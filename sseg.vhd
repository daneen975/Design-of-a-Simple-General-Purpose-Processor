   LIBRARY ieee;
   USE ieee.std_logic_1164.all;

   ENTITY sseg IS
     PORT (
       bcd : IN STD_LOGIC_VECTOR(3 DOWNTO 0);  -- BCD input (4 bits)
       sign : IN STD_LOGIC;                    -- Sign input (0: positive, 1: negative)
       leds_right : OUT STD_LOGIC_VECTOR(0 TO 6); -- Right 7-segment display (magnitude)
       leds_left : OUT STD_LOGIC_VECTOR(0 TO 6)   -- Left 7-segment display (sign)
     );
   END sseg;

   ARCHITECTURE Behavior OF sseg IS
   BEGIN
     PROCESS (bcd)
     BEGIN
       -- Right display shows the magnitude (0-F)
       CASE bcd IS
         WHEN "0000" => leds_right <= NOT "1111110"; -- 0
         WHEN "0001" => leds_right <= NOT "0110000"; -- 1
         WHEN "0010" => leds_right <= NOT "1101101"; -- 2
         WHEN "0011" => leds_right <= NOT "1111001"; -- 3
         WHEN "0100" => leds_right <= NOT "0110011"; -- 4
         WHEN "0101" => leds_right <= NOT "1011011"; -- 5
         WHEN "0110" => leds_right <= NOT "1011111"; -- 6
         WHEN "0111" => leds_right <= NOT "1110000"; -- 7
         WHEN "1000" => leds_right <= NOT "1111111"; -- 8
         WHEN "1001" => leds_right <= NOT "1111011"; -- 9
         WHEN "1010" => leds_right <= NOT "1110111"; -- A
         WHEN "1011" => leds_right <= NOT "0011111"; -- B
         WHEN "1100" => leds_right <= NOT "1001110"; -- C
         WHEN "1101" => leds_right <= NOT "0111101"; -- D
         WHEN "1110" => leds_right <= NOT "1001111"; -- E
         WHEN "1111" => leds_right <= NOT "1000111"; -- F
         WHEN OTHERS => leds_right <= NOT "0000000"; -- Blank or error
       END CASE;

       -- Left display shows the sign
       IF sign = '1' THEN
         leds_left <= "0000001"; -- Display "-" (middle segment ON)
       ELSE
         leds_left <= "0000000"; -- No sign (all segments OFF)
       END IF;

     END PROCESS;
   END Behavior;

