
library ieee;
use ieee.std_logic_1164.all;

entity test_cont30 is
	port
	(
		-- Input ports
		clk,D1,D2	: in  std_logic;
		reset : in  std_logic := '0';
		X : in std_logic_vector(3 downto 0 );
		
		-- Output ports

		Ocambio	: out std_logic_vector (5 downto 0);
		ODtotalU,ODtotalD,ODcambioU,ODcambioD,ODproducto : out std_logic_vector (6 downto 0 );
		monedacae,Oproducto, Osinproducto: out std_logic;
		ledPuerta,OSinStock,Orojo :out std_logic;
		
---------------------- SALIDAS DE PRUEBA 

		Ostock : out std_logic_vector (3 downto 0);
		Sdinero, Oprecio	: out std_logic_vector (5 downto 0);
		OSP1,OSP2,Oreset : out std_logic
	);
end test_cont30;


architecture arch_test_cont30 of test_cont30 is

------------------------SEÑALES----------------------------------------

	signal s_i,SQ1, SQ2, SP1,SP2,Smonedacae, Ssinstock,Ssinproducto : std_logic;
	signal Sproducto,SNoutil3,SNoutil4,Senable,Sreset : std_logic;
	signal reloj, pulso,Sflip1,Sflip2,Sflip3	: std_logic;
	signal Sbcd_u1,Sbcd_u2,Sbcd_d1,Sbcd_d2 : std_logic_vector (3 downto 0);
	signal SSele, Sstock : std_logic_vector (3 downto 0);
	signal Sprecio, Stotal,Scambio : std_logic_vector (5 downto 0);
	signal Shex : std_logic_vector (6 downto 0);
	
----------------------COMPONENTES--------------------------------------
	component divisor_frecuencia
			port
			(	
				-- Input ports
				clk	: in  std_logic;
				
				-- Output ports
				Sclk	: buffer std_logic
			);
	end component;
-----------------------------------------------------------------------	
component contador_multiplicador
		port
		(
			-- Input ports
			P5,P10, reset	: in  std_logic;
			
			-- Output ports
			Stotal	: out std_logic_vector (5 downto 0);
			monedacae	:	out std_logic
		);
	end component;
------------------------------------------------------------------------
component Dflipflop 
	port
	(
		-- Input ports
		clk, reset, D	: in  std_logic;
		
		-- Output ports
		Q, Qn, Qs: out std_logic
		
	);
end component;
-------------------------------------------------------------------------
component identificador_monedas 
	port
	(
		-- Input ports
		clk, reset, S1, S2	: in  std_logic;
		
		-- Output ports
		P1000, P500	: out std_logic
	);
end component;
--------------------------------------------------------------------------
component inventario_productos
    port (
        clk, reset: in  std_logic;
        sel       : in  std_logic_vector(3 downto 0);  -- producto seleccionado
        solicitar : in  std_logic;                     -- señal de compra
		  dinero		: in	std_logic_vector(5 downto 0);
        precio    : out std_logic_vector(5 downto 0);  -- precio del producto
        stock     : out std_logic_vector(3 downto 0);  -- stock disponible
        sin_stock : out std_logic                      -- 1 cuando no hay stock
    );
end component;
--------------------------------------------------------------------------
component comparador_proyecto 
    port(
        precio, dinero		  : in  std_logic_vector(5 downto 0);
        producto, sin_producto : out std_logic;  
        cambio      : out std_logic_vector(5 downto 0) 
               
    );
end component;
-------------------------------------------------------------------------
component hex_display
    port (
        X  : in  std_logic_vector (3 downto 0);  -- número en binario
        D0 : out std_logic_vector (6 downto 0);  -- display 7 segmentos
		  Sele: out std_logic_vector (3 downto 0)
    );
end component;
-------------------------------------------------------------------------
component reloj_puerta 
	port
	(
		-- Input ports
		clk, reset, enable	: in  std_logic;
		
		-- Output ports
		ledPuerta	: out std_logic
	);
end component;
-------------------------------------------------------------------------
component LedRojo
	port
	(
		-- Input ports
		clk, Puertabre	: in std_logic;
		
		-- Output ports
		LedRojo	: out std_logic
		
	);
end component;
-------------------------------------------------------------------------
component bits6_2bcd 
    port(
        bin_in  : in  std_logic_vector(5 downto 0);  -- entrada de 6 bits (0-63)
        bcd_u   : out std_logic_vector(3 downto 0);  -- unidades
        bcd_d   : out std_logic_vector(3 downto 0)   -- decenas
    );
end component;
-------------------------------------------------------------------------
 component bcdDoble 
    Port (
        A,B : in  STD_LOGIC_VECTOR(3 downto 0);
        F0: out STD_LOGIC_VECTOR(6 downto 0);
        F1: out STD_LOGIC_VECTOR(6 downto 0)
    );
end component;
-------------------------------------------------------------------------
component deco_bcd_7seg 

	port
	(
		-- Input ports
		D	: in  std_logic_vector (3 downto 0);

		-- Output ports
		D0	: out std_logic_vector (6 downto 0)
		
	);
end component;


-----------------------------BLOQUES-------------------------------------
begin


	--U0	: divisor_frecuencia port map (clk, reloj);
	U1 : Dflipflop port map (clk,reset,D1,SQ1);
	U2 : Dflipflop port map (clk,reset,D2,SQ2);
	U3 : Identificador_monedas port map (clk,reset, SQ1, SQ2,SP1, SP2);
	U4	: contador_multiplicador	port map (SP2,SP1, Sflip3,Stotal,monedacae);
	U5 : hex_display port map (X,Shex,SSele);
	U6 : inventario_productos port map (Sproducto,reset,SSele,Sproducto,Stotal,Sprecio,Ostock,Ssinstock);
	U7 : comparador_proyecto port map (Sprecio,Stotal,Sproducto,Ssinproducto,Scambio);
	U8 : reloj_puerta port map (clk, reset, Senable, ledPuerta);
	U9 : Dflipflop port map (clk, reset,Sproducto,SNoutil3, SNoutil4,Senable);
	U10: LedRojo port map (clk, Senable,ORojo);
	U11: Dflipflop port map (clk,reset,Sreset,Sflip1);
	U12: Dflipflop port map (clk,reset,Sflip1,Sflip2);
	U13: Dflipflop port map (not clk,reset,Sflip2,Sflip3);
	U14: bits6_2bcd port map (Stotal, Sbcd_u1,Sbcd_d1);
	U15: bits6_2bcd port map (Scambio,Sbcd_u2,Sbcd_d2);
	U16: bcdDoble port map (Sbcd_u1,Sbcd_d1,ODtotalU,ODtotalD);
	U17: bcdDoble port map (Sbcd_u2,Sbcd_d2,ODcambioU,ODcambioD);
	U18: deco_bcd_7seg port map (Ssele, ODproducto);
	
	
	
	Oproducto <= Sproducto ;
	Sreset <= Sproducto or Ssinproducto;
	
	----------------------------ETAPA DE PRUEBA-----------------
	Osinproducto <= Ssinproducto;
	Oprecio <= Sprecio;
	Osinstock <= Ssinstock;
	Oreset <= Sflip3;
	Ocambio <= Scambio;
	
	Sdinero <= Stotal;
	OSP1 <= SP1;
	OSP2 <= SP2;

	
	
end arch_test_cont30;
