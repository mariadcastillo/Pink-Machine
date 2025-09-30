library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bits6_2bcd is
    port(
        bin_in  : in  std_logic_vector(5 downto 0);  -- entrada de 6 bits (0-63)
        bcd_u   : out std_logic_vector(3 downto 0);  -- unidades
        bcd_d   : out std_logic_vector(3 downto 0)   -- decenas
    );
end bits6_2bcd;

architecture beh of bits6_2bcd is
    signal value : unsigned(5 downto 0);
    signal temp_units : integer range 0 to 9;
    signal temp_tens  : integer range 0 to 6;
begin
    process(bin_in)
    begin
        value <= unsigned(bin_in);

        -- calcular decenas y unidades
        temp_tens  <= to_integer(value) / 10;
        temp_units <= to_integer(value) mod 10;

        -- asignar a salidas BCD
        bcd_d <= std_logic_vector(to_unsigned(temp_tens,4));
        bcd_u <= std_logic_vector(to_unsigned(temp_units,4));
    end process;
end beh;