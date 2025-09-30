library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity comparador_proyecto is
    port(
        precio, dinero		  : in  std_logic_vector(5 downto 0);
        producto, sin_producto : out std_logic;  
        cambio      : out std_logic_vector(5 downto 0) 
               
    );
end comparador_proyecto;

architecture arch_comparador_proyecto of comparador_proyecto is
begin
    process(precio, dinero)
    begin
        -- valores por defecto
        producto     <= '0';
        sin_producto <= '0';
        cambio       <= "000000";

        if (dinero >= precio) and (precio /= "000000") then
            if (dinero = precio) then
                producto <= '1';      
                cambio   <= "000000"; -- no hay cambio
            else
                producto <= '1';
                cambio   <= dinero - precio; -- da el cambio
            end if;
        else
				sin_producto <= '1'; -- no alcanza o precio inválido
				cambio <= dinero;
        end if;
    end process;
end arch_comparador_proyecto;
