LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity decoder4to16 is
    Port ( w : in  STD_LOGIC_VECTOR (3 downto 0);
           En : in  STD_LOGIC;
           y : out STD_LOGIC_VECTOR (15 downto 0));
end decoder4to16;

architecture Behavior of decoder4to16 is
begin
    process(w, En)
    begin
        if En = '1' then
            case w is
                when "0000" => y <= "0000000000000001";
                when "0001" => y <= "0000000000000010";
                when "0010" => y <= "0000000000000100";
                when "0011" => y <= "0000000000001000";
                when "0100" => y <= "0000000000010000";
                when "0101" => y <= "0000000000100000";
                when "0110" => y <= "0000000001000000";
                when "0111" => y <= "0000000010000000";
                when "1000" => y <= "0000000100000000";
                when "1001" => y <= "0000001000000000";
                when "1010" => y <= "0000010000000000";
                when "1011" => y <= "0000100000000000";
                when "1100" => y <= "0001000000000000";
                when "1101" => y <= "0010000000000000";
                when "1110" => y <= "0100000000000000";
                when "1111" => y <= "1000000000000000";
                when others => y <= "0000000000000000";
            end case;
        else
            y <= "0000000000000000";
        end if;
    end process;
end Behavior;

