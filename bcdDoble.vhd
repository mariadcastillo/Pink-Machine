library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcdDoble is
    Port (
        A,B : in  STD_LOGIC_VECTOR(3 downto 0);
        F0: out STD_LOGIC_VECTOR(6 downto 0);
        F1: out STD_LOGIC_VECTOR(6 downto 0)
    );
end bcdDoble;

architecture arch_bcdDoble of bcdDoble is
begin

    with A select
        F0 <= "1000000" when "0000", -- 0
                "1111001" when "0001", -- 1
                "0100100" when "0010", -- 2
                "0110000" when "0011", -- 3
                "0011001" when "0100", -- 4
                "0010010" when "0101", -- 5
                "0000010" when "0110", -- 6
                "1111000" when "0111", -- 7
                "0000000" when "1000", -- 8
                "0010000" when "1001", -- 9
                "1111111" when others; -- apagado / irrelevante
    with B select
        F1 <= "1000000" when "0000", -- 0
                "1111001" when "0001", -- 1
                "0100100" when "0010", -- 2
                "0110000" when "0011", -- 3
                "0011001" when "0100", -- 4
                "0010010" when "0101", -- 5
                "0000010" when "0110", -- 6
                "1111000" when "0111", -- 7
                "0000000" when "1000", -- 8
                "0010000" when "1001", -- 9
                "1111111" when others; -- apagado / irrelevante

end arch_bcdDoble;