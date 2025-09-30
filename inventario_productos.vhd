library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inventario_productos is
    port (
        clk       : in  std_logic;
        reset     : in  std_logic;
        sel       : in  std_logic_vector(3 downto 0);  -- producto seleccionado
        solicitar : in  std_logic;                     -- señal de compra
        precio    : out std_logic_vector(5 downto 0);  -- precio del producto
        stock     : out std_logic_vector(3 downto 0);  -- stock disponible
        sin_stock : out std_logic                      -- 1 cuando no hay stock
    );
end entity;

architecture arch_stock of inventario_productos is
    -- registros de stock para los 16 productos
    type stock_array is array (0 to 15) of unsigned(3 downto 0);
    signal stock_reg : stock_array;
begin
    -- Inicialización y actualización del stock
    process(clk, reset)
    begin
        if reset = '1' then
            -- inicializamos el stock
            stock_reg(0)  <= to_unsigned(0,4);
            stock_reg(1)  <= to_unsigned(3,4);
            stock_reg(2)  <= to_unsigned(3,4);
            stock_reg(3)  <= to_unsigned(3,4);
            stock_reg(4)  <= to_unsigned(3,4);
            stock_reg(5)  <= to_unsigned(3,4);
            stock_reg(6)  <= to_unsigned(3,4);
            stock_reg(7)  <= to_unsigned(3,4);
            stock_reg(8)  <= to_unsigned(3,4);
            stock_reg(9)  <= to_unsigned(3,4);
            stock_reg(10) <= to_unsigned(3,4);
            stock_reg(11) <= to_unsigned(3,4);
            stock_reg(12) <= to_unsigned(3,4);
            stock_reg(13) <= to_unsigned(3,4);
            stock_reg(14) <= to_unsigned(3,4);
            stock_reg(15) <= to_unsigned(3,4); 
        elsif (clk'event and clk = '0') then
            if solicitar = '1' then
                case sel is
                    when "0000" => if stock_reg(0) > 0 then stock_reg(0) <= stock_reg(0) - 1; end if;
                    when "0001" => if stock_reg(1) > 0 then stock_reg(1) <= stock_reg(1) - 1; end if;
                    when "0010" => if stock_reg(2) > 0 then stock_reg(2) <= stock_reg(2) - 1; end if;
                    when "0011" => if stock_reg(3) > 0 then stock_reg(3) <= stock_reg(3) - 1; end if;
                    when "0100" => if stock_reg(4) > 0 then stock_reg(4) <= stock_reg(4) - 1; end if;
                    when "0101" => if stock_reg(5) > 0 then stock_reg(5) <= stock_reg(5) - 1; end if;
                    when "0110" => if stock_reg(6) > 0 then stock_reg(6) <= stock_reg(6) - 1; end if;
                    when "0111" => if stock_reg(7) > 0 then stock_reg(7) <= stock_reg(7) - 1; end if;
                    when "1000" => if stock_reg(8) > 0 then stock_reg(8) <= stock_reg(8) - 1; end if;
                    when "1001" => if stock_reg(9) > 0 then stock_reg(9) <= stock_reg(9) - 1; end if;
                    when "1010" => if stock_reg(10) > 0 then stock_reg(10) <= stock_reg(10) - 1; end if;
                    when "1011" => if stock_reg(11) > 0 then stock_reg(11) <= stock_reg(11) - 1; end if;
                    when "1100" => if stock_reg(12) > 0 then stock_reg(12) <= stock_reg(12) - 1; end if;
                    when "1101" => if stock_reg(13) > 0 then stock_reg(13) <= stock_reg(13) - 1; end if;
                    when "1110" => if stock_reg(14) > 0 then stock_reg(14) <= stock_reg(14) - 1; end if;
                    when "1111" => if stock_reg(15) > 0 then stock_reg(15) <= stock_reg(15) - 1; end if;
                    when others => null;
                end case;
            end if;
        end if;
    end process;

    -- lógica combinacional para precio, stock actual y señal sin_stock
    process(sel, stock_reg, solicitar)
    variable st : unsigned(3 downto 0);
	 variable pr : unsigned(5 downto 0);
    begin
		  st := (others => '0');
        pr := (others => '0');
		  case sel is
            when "0000" => pr :=(to_unsigned(0, 6));  st := stock_reg(0);   -- no product → $0
            when "0001" => pr :=(to_unsigned(5, 6));  st := stock_reg(1);   -- producto 1 → $5
            when "0010" => pr :=(to_unsigned(15, 6)); st := stock_reg(2);   -- producto 2 → $15
            when "0011" => pr :=(to_unsigned(10, 6)); st := stock_reg(3);   -- producto 3 → $10
            when "0100" => pr :=(to_unsigned(20, 6)); st := stock_reg(4);	 -- producto 4 → $20
            when "0101" => pr :=(to_unsigned(25, 6)); st := stock_reg(5);	 -- producto 5 → $25
            when "0110" => pr :=(to_unsigned(30, 6)); st := stock_reg(6);	 -- producto 6 → $30
            when "0111" => pr :=(to_unsigned(35, 6)); st := stock_reg(7);	 -- producto 7 → $35
            when "1000" => pr :=(to_unsigned(5, 6));  st := stock_reg(8);	 -- producto 8 → $5
            when "1001" => pr :=(to_unsigned(40, 6)); st := stock_reg(9);	 -- producto 9 → $40
            when "1010" => pr :=(to_unsigned(15, 6)); st := stock_reg(10);	 -- producto 10 → $15
            when "1011" => pr :=(to_unsigned(5, 6));  st := stock_reg(11);	 -- producto 11 → $5
            when "1100" => pr :=(to_unsigned(30, 6)); st := stock_reg(12);	 -- producto 12 → $30
            when "1101" => pr :=(to_unsigned(10, 6)); st := stock_reg(13);	 -- producto 13 → $10
            when "1110" => pr :=(to_unsigned(5, 6));  st := stock_reg(14);	 -- producto 14 → $5
            when "1111" => pr :=(to_unsigned(25, 6)); st := stock_reg(15);	 -- producto 15 → $25
            when others => pr := (others => '0');    st := (others => '0'); -- seguridad
        end case;

        -- si no hay stock, precio = 0 y señal de sin_stock activa
        if (st = 0 and sel /= "0000") then
            precio    <= (others => '0');
            sin_stock <= '1';
        else
            precio    <= std_logic_vector(pr);
            sin_stock <= '0';
        end if;
		  
		  stock <= std_logic_vector(st);
		  
    end process;
end architecture;
