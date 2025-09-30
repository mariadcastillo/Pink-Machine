library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity identificador_monedas is
	port
	(
		-- Input ports
		clk, reset, S1, S2	: in  std_logic;
		
		-- Output ports
		P1000, P500	: out std_logic
	);
end identificador_monedas;

architecture arch_id_monedas of identificador_monedas is

	-- Declarations (optional)
	signal cond_1000, cond_500 : std_logic;
	signal cond_1000_d, cond_500_d : std_logic;  -- versiones retardadas
	
	begin
	
    -- Condiciones de detección
	cond_1000 <= S1 and S2;          -- Detecta "11"
	cond_500  <= (not S1) and S2;    -- Detecta "01"

	process(clk, reset)
	begin
		if (reset = '1') then
			cond_1000_d <= '0';
			cond_500_d  <= '0';
			P1000  <= '0';
			P500   <= '0';

		elsif (clk'event and clk = '1') then
		
			-- guardar valores anteriores
			cond_1000_d <= cond_1000;
			cond_500_d  <= cond_500;

			-- generar pulsos (solo duran un ciclo de reloj)
			if (cond_1000 = '1' and cond_1000_d = '0') then
				P1000 <= '1';
			else
				P1000 <= '0';
			end if;

			if (cond_500 = '1' and cond_500_d = '0') then
				P500 <= '1';
			else
				P500 <= '0';
			end if;
		end if;
    end process;

end arch_id_monedas;
