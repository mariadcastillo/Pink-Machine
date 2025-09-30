library ieee;
use ieee.std_logic_1164.all;

entity DivisorFreq_ledrojo is
	port
	(
		-- Input ports
		clk	: in  std_logic;
		
		-- Output ports
		Sclk	: buffer std_logic
	);
end DivisorFreq_ledrojo;

architecture arch_DivisorFreq_ledrojo of DivisorFreq_ledrojo is

	-- Declarations (optional)
	signal count1 : integer range 0 to 25000000;

begin

	-- Process Statement (optional)
	process (clk)
		
		begin
			if (clk'event and clk = '1') then
				count1 <= count1 + 1;
				
				if (count1 = 25000000) then
					Sclk <= not Sclk;
					count1 <= 0;
				end if;
			end if;
	end process;

end arch_DivisorFreq_ledrojo;
