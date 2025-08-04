LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU3 IS
    PORT (
        Clk        : IN  std_logic;                  -- Clock signal
        Reset      : IN  std_logic;                  -- Reset signal
        A          : IN  std_logic_vector(7 DOWNTO 0); -- 8-bit input Register 1
        B          : IN  std_logic_vector(7 DOWNTO 0); -- 8-bit input Register 2
        student_id : IN  std_logic_vector(3 DOWNTO 0); -- 4-bit student ID
        opcode     : IN  std_logic_vector(15 DOWNTO 0); -- ALU function selector from opcode
        Result_1   : OUT std_logic_vector(3 DOWNTO 0); -- Most Significant Nibble (4-bit)
        Result_2   : OUT std_logic_vector(3 DOWNTO 0)  -- Least Significant Nibble (4-bit)
    );
END ALU3;

ARCHITECTURE Behavior OF ALU3 IS
    SIGNAL signed_A      : signed(7 DOWNTO 0);
    SIGNAL signed_B      : signed(7 DOWNTO 0);
    SIGNAL signed_result : signed(7 DOWNTO 0);
    SIGNAL result_temp   : std_logic_vector(7 DOWNTO 0);
BEGIN
    signed_A <= signed(A);
    signed_B <= signed(B);

    PROCESS (Clk, Reset)
    BEGIN
        IF Reset = '1' THEN
            signed_result <= (OTHERS => '0');
        ELSIF rising_edge(Clk) THEN
            CASE opcode IS
                WHEN "0000000000000001" =>  -- Replace odd bits of A with odd bits of B
                    result_temp <= (A(7) & B(6) & A(5) & B(4) & A(3) & B(2) & A(1) & B(0));
                    signed_result <= signed(result_temp);

                WHEN "0000000000000010" =>  -- NAND A and B
                    result_temp <= A NAND B;
                    signed_result <= signed(result_temp);

                WHEN "0000000000000100" =>  -- Sum A and B, decrease by 5
                    signed_result <= signed_A + signed_B - 5;

                WHEN "0000000000001000" =>  -- 2's complement of B
                    signed_result <= -signed_B;

                WHEN "0000000000010000" =>  -- Invert even bits of B
                    result_temp <= B(7) & NOT B(6) & B(5) & NOT B(4) & B(3) & NOT B(2) & B(1) & NOT B(0);
                    signed_result <= signed(result_temp);

                WHEN "0000000000100000" =>  -- Shift A left by 2, input bit = 1
                    result_temp <= std_logic_vector(unsigned(A) sll 2);
                    result_temp(1 DOWNTO 0) <= "11";
                    signed_result <= signed(result_temp);

                WHEN "0000000001000000" =>  -- Null output
                    signed_result <= (OTHERS => '0');

                WHEN "0000000010000000" =>  -- 2's complement of A
                    signed_result <= -signed_A;

                WHEN OTHERS =>
                    signed_result <= (OTHERS => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- Assign the results to Result_1 and Result_2
    Result_1 <= std_logic_vector(signed_result(7 DOWNTO 4));  -- MSB (Most Significant Nibble)
    Result_2 <= std_logic_vector(signed_result(3 DOWNTO 0));  -- LSB (Least Significant Nibble)

END Behavior;
