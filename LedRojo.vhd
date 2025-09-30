
library ieee;
use ieee.std_logic_1164.all;

entity LedRojo is
	port
	(
		-- Input ports
		clk, Puertabre	: in std_logic;
		
		-- Output ports
		LedRojo	: out std_logic
		
	);
end LedRojo;
architecture arch_LedRojo of LedRojo is

	component DivisorFreq_ledrojo 
		port
		(
			-- Input ports
			clk	: in  std_logic;
			
			-- Output ports
			Sclk	: buffer std_logic
		);
	end component;
begin

	LedRojo <= Puertabre and clk;

end arch_LedRojo;

