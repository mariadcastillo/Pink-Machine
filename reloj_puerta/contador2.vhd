library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador2 is
	port
	(
		-- Input ports
		clk, reset, enable	: in  std_logic;
		
		-- Output ports
		Q	: out std_logic_vector (3 downto 0);
		QD	: out std_logic_vector (3 downto 0);
		led : out std_logic := '0'
	);
end contador2;


architecture arch_contador2 of contador2 is

	-- Declarations (optional)
	signal Qs	:	unsigned (5 downto 0);
	signal Qunidades	:	unsigned (3 downto 0);
	signal Qdecenas	:	unsigned	(3 downto 0);
	signal pause	: std_logic := '0' ;

	begin
	

	-- Process Statement (optional)
	CONTADOR	:	process (clk, reset)
		begin
		
			if (reset = '1') then
				Qs <= "000000";
				pause <= '0';
			elsif (clk'event and clk = '1' and enable = '1') then
				if pause = '0' then
					if Qs = "110010" then  -- 50 decimal
                    pause <= '1';     -- activa pausa
						  led <= '1';
                else
                    Qs <= Qs + 1;     -- incrementa
						  led <= '0';
					end if;
				end if;				

			end if;
	end process;
	
        -- dividir en decenas y unidades
        Qdecenas  <= to_unsigned(to_integer(Qs) / 10, 4);
        Qunidades <= to_unsigned(to_integer(Qs) mod 10, 4);

	
	QD <= std_logic_vector(Qdecenas);
	Q <= std_logic_vector(Qunidades);

end arch_contador2;
