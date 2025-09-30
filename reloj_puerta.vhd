library ieee;
use ieee.std_logic_1164.all;

entity reloj_puerta is
	port
	(
		-- Input ports
		clk, reset, enable	: in  std_logic;
		
		-- Output ports
		ledPuerta	: out std_logic;

		d3u, d3d	: out std_logic_vector (6 downto 0)
	);
end reloj_puerta;


architecture arch_reloj_puerta of reloj_puerta is
	
	signal s_i : std_logic;
	signal reloj, pulso: std_logic;
	signal scont_bcd, dcont_bcd: std_logic_vector (3 downto 0);


	-- Declarations (optional)
	component divisor_frecuencia
			port
			(	
				-- Input ports
				clk	: in  std_logic;
				
				-- Output ports
				out1	: buffer std_logic
			);
	end component;
		
	component contador --Cuenta de 0 a 30
			port
			(
				-- Input ports
				clk, reset, enable	: in  std_logic;
				
				-- Output ports
				Q	: out std_logic_vector (3 downto 0);
				QD	: out std_logic_vector (3 downto 0);
				led : out std_logic := '0'
			);
	end component;
	
	component deco_bcd_7seg
			port
			(
				-- Input ports
				D	: in  std_logic_vector (3 downto 0);

				-- Output ports
				D0	: out std_logic_vector (6 downto 0)
				
			);
	end component;

begin


	U0	:	divisor_frecuencia port map (clk, reloj);
	U1	:	contador	port map (reloj, reset, enable, scont_bcd, dcont_bcd, ledPuerta);
	U2	:	deco_bcd_7seg port map (scont_bcd, d3u);
	U3	:	deco_bcd_7seg port map (dcont_bcd, d3d);
	

end arch_reloj_puerta;
