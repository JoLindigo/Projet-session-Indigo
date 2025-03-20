----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2025 02:00:35 AM
-- Design Name: 
-- Module Name: viewport - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity viewport is
    Port ( i_print_px_y : in STD_LOGIC_VECTOR (9 downto 0);
           i_print_px_x : in STD_LOGIC_VECTOR (9 downto 0);
           i_offset_y : in STD_LOGIC_VECTOR (9 downto 0);
           i_offset_x : in STD_LOGIC_VECTOR (9 downto 0);
           o_global_x : out STD_LOGIC_VECTOR (9 downto 0);
           o_global_y : out STD_LOGIC_VECTOR (9 downto 0));
end viewport;

architecture Behavioral of viewport is
    
    constant SCREEN_WIDTH  : unsigned(9 downto 0) := to_unsigned(640, 10); -- Remplacez par la largeur réelle
    constant SCREEN_HEIGHT : unsigned(9 downto 0) := to_unsigned(360, 10);  -- Remplacez par la hauteur réelle
    
    signal sum_x, sum_y : std_logic_vector(11 downto 0);
    signal carry : std_logic_vector(1 downto 0);
    
    signal extended_x, extended_y, extended_offset_x, extended_offset_y : std_logic_vector(11 downto 0);
    
begin
    
    -- Extension des entrées 10 bits en 12 bits
    extended_x        <= "00" & i_print_px_x;
    extended_y        <= "00" & i_print_px_y;
    extended_offset_x <= "00" & i_offset_x;
    extended_offset_y <= "00" & i_offset_y;
    
    UX : entity work.Add12bits
        port map(
           X => extended_x,
           Y => extended_offset_x,
           Cin => '0',
           Sum => sum_x,
           Cout => carry(0)
        );
        
    UY : entity work.Add12bits
        port map(
           X => extended_y,
           Y => extended_offset_y,
           Cin => '0',
           Sum => sum_y,
           Cout => carry(1)
        );

    process(sum_x, sum_y)
    begin
        -- Vérification des limites
        if unsigned(sum_x(9 downto 0)) >= SCREEN_WIDTH then
            o_global_x <= std_logic_vector(TO_UNSIGNED(to_integer(unsigned(sum_x(9 downto 0))) - to_integer(SCREEN_WIDTH), 10));
        else
            o_global_x <= sum_x(9 downto 0);
        end if;
        
        if unsigned(sum_y(9 downto 0)) >= SCREEN_HEIGHT then
            o_global_y <= std_logic_vector(TO_UNSIGNED(to_integer(unsigned(sum_y(9 downto 0))) - to_integer(SCREEN_HEIGHT), 10));
        else
            o_global_y <= sum_y(9 downto 0);
        end if;
    end process;
    
end Behavioral;