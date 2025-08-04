LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sseg_3 IS
  PORT (
    bcd        : IN STD_LOGIC_VECTOR(3 DOWNTO 0);  -- BCD input (4 bits)
    leds_right : OUT STD_LOGIC_VECTOR(0 TO 6)      -- Right 7-segment display
  );
END sseg_3;

ARCHITECTURE Behavior OF sseg_3 IS
BEGIN
  PROCESS (bcd)
  BEGIN
    -- Map 4-bit BCD input to 7-segment display output
    CASE bcd IS
      -- Digits less than or equal to 3: Display "Y"
      WHEN "0000" => leds_right <= NOT "0111011"; -- 0: Y
      WHEN "0001" => leds_right <= NOT "0111011"; -- 1: Y
      WHEN "0010" => leds_right <= NOT "0111011"; -- 2: Y
      WHEN "0011" => leds_right <= NOT "0111011"; -- 3: Y

      -- Digits greater than 3: Display "N"
      WHEN "0100" => leds_right <= NOT "1110110"; -- 4: N
      WHEN "0101" => leds_right <= NOT "1110110"; -- 5: N
      WHEN "0110" => leds_right <= NOT "1110110"; -- 6: N
      WHEN "0111" => leds_right <= NOT "1110110"; -- 7: N
      WHEN "1000" => leds_right <= NOT "1110110"; -- 8: N
      WHEN "1001" => leds_right <= NOT "1110110"; -- 9: N

      -- Default case: Blank display
      WHEN OTHERS => leds_right <= "0000000"; -- Blank/error
    END CASE;
  END PROCESS;
END Behavior;
