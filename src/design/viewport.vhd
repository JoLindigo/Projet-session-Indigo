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
    Port ( i_clk            : in std_logic;
           i_reset          : in std_logic;
           i_print_px_y     : in STD_LOGIC_VECTOR (11 downto 0);
           i_print_px_x     : in STD_LOGIC_VECTOR (11 downto 0);
           i_offset_y       : in STD_LOGIC_VECTOR (9 downto 0);
           i_offset_x       : in STD_LOGIC_VECTOR (9 downto 0);
           i_ch_offset_en   : in std_logic;
           o_global_x       : out STD_LOGIC_VECTOR (11 downto 0);
           o_global_y       : out STD_LOGIC_VECTOR (11 downto 0));
end viewport;

architecture Behavioral of viewport is
    constant FULL_WIDTH  : unsigned(9 downto 0) := to_unsigned(1023, 10);
    constant FULL_HEIGHT  : unsigned(9 downto 0) := to_unsigned(1023, 10);
    
--    constant VIEWPORT_WIDTH  : unsigned(9 downto 0) := to_unsigned(640, 10); -- Remplacez par la largeur réelle
--    constant VIEWPORT_HEIGHT : unsigned(9 downto 0) := to_unsigned(360, 10);  -- Remplacez par la hauteur réelle
    
    signal sum_x, sum_y : std_logic_vector(11 downto 0);
    
    signal s_offset_x : std_logic_vector(9 downto 0) := (others => '0');
    signal s_offset_y : std_logic_vector(9 downto 0) := (others => '0');
begin
    sum_x <= std_logic_vector(unsigned(i_print_px_x) + unsigned(s_offset_x));
    sum_y <= std_logic_vector(unsigned(i_print_px_y) + unsigned(s_offset_y));
    
    process(i_clk, i_reset)
    begin
        if i_reset = '1' then
           s_offset_x <= (others => '0');
           s_offset_y <= (others => '0');
        elsif rising_edge(i_clk) then
            if i_ch_offset_en = '1' then
                s_offset_x <= i_offset_x;
                s_offset_y <= i_offset_y;
            end if;
        end if;      
    end process;
    
    process(sum_x, sum_y)
    begin
        -- Vérification des limites
        if unsigned(sum_x) > FULL_WIDTH then
            o_global_x <= std_logic_vector(unsigned(sum_x) - FULL_WIDTH);
        else
            o_global_x <= sum_x;
        end if;
        
        if unsigned(sum_y) > FULL_HEIGHT then
            o_global_y <= std_logic_vector(unsigned(sum_y) - FULL_HEIGHT);
        else
            o_global_y <= sum_y;
        end if;
    end process;
end Behavioral;