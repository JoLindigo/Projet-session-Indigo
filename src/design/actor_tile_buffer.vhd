----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2025 11:59:20
-- Design Name: 
-- Module Name: actor_tile_buffer - Behavioral
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

entity actor_tile_buffer is
    Port ( i_tile_id : in STD_LOGIC_VECTOR (5 downto 0);
           i_tile_x : in STD_LOGIC_VECTOR (3 downto 0);
           i_tile_y : in STD_LOGIC_VECTOR (3 downto 0);
           i_ch_tile_pixel_color : in STD_LOGIC_VECTOR (4 downto 0);
           i_ch_tile_x : in STD_LOGIC_VECTOR (3 downto 0);
           i_ch_tile_y : in STD_LOGIC_VECTOR (3 downto 0);
           i_ch_tile_id : in STD_LOGIC_VECTOR (5 downto 0);
           i_ch_en : in STD_LOGIC;
           i_reset : in STD_LOGIC;
           i_clk: in STD_LOGIC;
           --i_bg_tile_en : in STD_LOGIC;
           o_color_code : out STD_LOGIC_VECTOR (4 downto 0));
end actor_tile_buffer;

architecture Behavioral of actor_tile_buffer is
type tile_buffer is array(0 to 31, 0 to 15, 0 to 15) of STD_LOGIC_VECTOR (4 downto 0);
signal s_tiles: tile_buffer := (others => (others => (others => (others => '0')))); 
begin
    base: process(i_reset, i_clk)
    begin
        if i_reset = '1' then
            s_tiles <= (others => (others => (others => (others => '0'))));
        elsif rising_edge(i_clk) then
            o_color_code <= s_tiles(to_integer(unsigned(i_tile_id)), 
                                    to_integer(unsigned(i_tile_x)), 
                                    to_integer(unsigned(i_tile_y))); 
                            
            if i_ch_en = '1' then
            s_tiles(to_integer(unsigned(i_ch_tile_id)), 
                    to_integer(unsigned(i_ch_tile_x)), 
                    to_integer(unsigned(i_ch_tile_y))) <= i_ch_tile_pixel_color;
            end if;
        end if;
    end process;
end Behavioral;
