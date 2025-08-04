LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

entity ALU is
    Port (
        clock : in std_logic;
        Reset : in std_logic;
        A : in unsigned(7 downto 0);
        B : in unsigned(7 downto 0);
        OP : in std_logic_vector(15 downto 0);
        Neg : out std_logic;
        R1 : out std_logic_vector(3 downto 0);
        R2 : out std_logic_vector(3 downto 0)
    );
end ALU;

architecture calculation of ALU is
    signal Reg1, Reg2, Result : unsigned(7 downto 0) := (others => '0');
    signal BCD_Result : unsigned(7 downto 0);
begin
    Reg1 <= A;
    Reg2 <= B;
    
    process(clock, Reset)
    begin
        if Reset = '1' then
            Result <= (others => '0');
            Neg <= '0';
        elsif rising_edge(Clock) then
            case OP is
                when "0000000000000001" => Result <= Reg1 + Reg2;
                when "0000000000000010" => 
                    if (Reg2 > Reg1) then
                        Result <= (Reg1 + (NOT Reg2 + 1));
                        Neg <= '1';
                    else
                        Result <= (Reg1 - Reg2);
                        Neg <= '0';
                    end if;
                when "0000000000000100" => 
                    Result <= NOT Reg1;
                    Neg <= NOT Reg1(7);
                when "0000000000001000" => Result <= (NOT (Reg1 AND Reg2));
                when "0000000000010000" => Result <= (NOT (Reg1 OR Reg2));
                when "0000000000100000" => Result <= (Reg1 AND Reg2);
                when "0000000001000000" => Result <= Reg1 XOR Reg2;
                when "0000000010000000" => Result <= (Reg1 OR Reg2);
                when others => Result <= (others => '0');
            end case;
        end if;
    end process;

    -- Binary to BCD Conversion Process
    process(Result)
        variable temp : unsigned(7 downto 0);
        variable bcd : unsigned(11 downto 0) := (others => '0');
    begin
        bcd := (others => '0');
        temp := Result;
        for i in 0 to 7 loop
            if bcd(3 downto 0) > 4 then 
                bcd(3 downto 0) := bcd(3 downto 0) + 3;
            end if;
            if bcd(7 downto 4) > 4 then 
                bcd(7 downto 4) := bcd(7 downto 4) + 3;
            end if;
            bcd := bcd(10 downto 0) & temp(7);
            temp := temp(6 downto 0) & '0';
        end loop;
        BCD_Result <= bcd(7 downto 0);
    end process;

    R1 <= std_logic_vector(BCD_Result(7 downto 4));
    R2 <= std_logic_vector(BCD_Result(3 downto 0));

end calculation;
