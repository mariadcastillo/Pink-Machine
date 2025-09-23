library ieee;
use ieee.std_logic_1164.all;

entity divisor_frecuencia is
	port
	(
		-- Input ports
		clk	: in  std_logic;
		
		-- Output ports
		out1	: buffer std_logic
	);
end divisor_frecuencia;

architecture arch_div_freq of divisor_frecuencia is

	-- Declarations (optional)
	signal count1 : integer range 0 to 50000000;

begin

	-- Process Statement (optional)
	process (clk)
		
		begin
			if (clk'event and clk = '1') then
				count1 <= count1 + 1;
				
				if (count1 = 50000000) then
					out1 <= not out1;
					count1 <= 0;
				end if;
			end if;
	end process;

end arch_div_freq;
