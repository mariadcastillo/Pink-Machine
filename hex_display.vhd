library ieee;
use ieee.std_logic_1164.all;

entity hex_display is
    port (
        X  : in  std_logic_vector (3 downto 0);  -- número en binario
        D0 : out std_logic_vector (6 downto 0)   -- display 7 segmentos
    );
end hex_display;

architecture arch of hex_display is
begin
    process (X)
    begin
        case X is
            when "0000" => D0 <= "1000000"; -- 0
            when "0001" => D0 <= "1111001"; -- 1
            when "0010" => D0 <= "0100100"; -- 2
            when "0011" => D0 <= "0110000"; -- 3
            when "0100" => D0 <= "0011001"; -- 4
            when "0101" => D0 <= "0010010"; -- 5
            when "0110" => D0 <= "0000010"; -- 6
            when "0111" => D0 <= "1111000"; -- 7
            when "1000" => D0 <= "0000000"; -- 8
            when "1001" => D0 <= "0010000"; -- 9
            when "1010" => D0 <= "0001000"; -- A
            when "1011" => D0 <= "0000011"; -- b
            when "1100" => D0 <= "1000110"; -- C
            when "1101" => D0 <= "0100001"; -- d
            when "1110" => D0 <= "0000110"; -- E
            when "1111" => D0 <= "0001110"; -- F
            when others => D0 <= "1111111"; -- apagado
        end case;
    end process;
end arch;

