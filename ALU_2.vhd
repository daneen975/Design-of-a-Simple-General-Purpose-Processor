LIBRARY ieee;  
USE ieee.std_logic_1164.all;  
USE ieee.numeric_std.all;  
  
ENTITY ALU_2 IS  
    PORT (  
        Clk        : in  std_logic;  
        Reset      : in  std_logic;  
        A          : in  std_logic_vector(7 DOWNTO 0); -- 8-bit input A  
        B          : in  std_logic_vector(7 DOWNTO 0); -- 8-bit input B  
        opcode     : in  std_logic_vector(15 DOWNTO 0); -- ALU function selector  
        Result_1   : out std_logic_vector(3 DOWNTO 0); -- Most Significant Nibble (4-bit)  
        Result_2   : out std_logic_vector(3 DOWNTO 0); -- Least Significant Nibble (4-bit)  
        sign_1     : out std_logic;                   -- Sign indicator for Result_1  
        sign_2     : out std_logic                    -- Sign indicator for Result_2  
    );  
END ALU_2;  
  
ARCHITECTURE Behavior OF ALU_2 IS  
    SIGNAL signed_A      : signed(7 DOWNTO 0);   -- Signed version of A  
    SIGNAL signed_B      : signed(7 DOWNTO 0);   -- Signed version of B  
    SIGNAL signed_result : signed(7 DOWNTO 0);   -- Intermediate signed result  
    SIGNAL result_temp   : std_logic_vector(7 DOWNTO 0); -- Temporary result  
BEGIN  
    -- Convert inputs to signed values for arithmetic operations  
    signed_A <= signed(A);  
    signed_B <= signed(B);  
  
    PROCESS (signed_A, signed_B, opcode)  
    BEGIN  
        CASE opcode IS  
            -- Function 1: Replace the odd bits of A with odd bits of B  
            WHEN "1000000000000000" =>  
                result_temp <= A(6) & B(5) & A(4) & B(3) & A(2) & B(1) & A(0) & B(7);  
                signed_result <= signed(result_temp);  
  
            -- Function 2: Produce the result of NANDing A and B  
            WHEN "0100000000000000" =>  
                result_temp <= NOT (A AND B);  
                signed_result <= signed(result_temp);  
  
            -- Function 3: Calculate the summation of A and B and decrease it by 5  
            WHEN "0010000000000000" =>  
                signed_result <= signed_A + signed_B - 5;  
  
            -- Function 4: Produce the 2's complement of B  
            WHEN "0001000000000000" =>  
                signed_result <= -signed_B;  
  
            -- Function 5: Invert the even bits of B  
            WHEN "0000100000000000" =>  
                result_temp <= B(7) & NOT B(6) & B(5) & NOT B(4) & B(3) & NOT B(2) & B(1) & NOT B(0);  
                signed_result <= signed(result_temp);  
  
            -- Function 6: Shift A to the left by 2 bits, input bit = 1 (SHL)  
            WHEN "0000010000000000" =>  
                result_temp <= A(5 DOWNTO 0) & "11";  
                signed_result <= signed(result_temp);  
  
            -- Function 7: Produce null on the output  
            WHEN "0000001000000000" =>  
                signed_result <= (others => '0');  
  
            -- Function 8: Produce the 2's complement of A  
            WHEN "0000000100000000" =>  
                signed_result <= -signed_A;  
  
            -- Default case: Set result to zero  
            WHEN OTHERS =>  
                signed_result <= (others => '0');  
        END CASE;  
    END PROCESS;  
  
    -- Assign Most Significant Nibble and Least Significant Nibble  
    Result_1  <= std_logic_vector(signed_result(7 DOWNTO 4));  
    Result_2  <= std_logic_vector(signed_result(3 DOWNTO 0));  
  
    -- Sign indicators for MSN and LSN  
    sign_1 <= '1' WHEN signed_result(7) = '1' ELSE '0';  
    sign_2 <= '1' WHEN signed_result(3) = '1' ELSE '0';  
  
END Behavior;


