----------------------------------------------------------------------------------
-- Company: Indigo ftw
-- Engineer: Samuel Simard
-- 
-- Create Date: 03/05/2025 11:59:04 AM
-- Design Name: 
-- Module Name: background_buffer - Behavioral
-- Project Name: PPU
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity background_buffer is
    Port ( clk           : in STD_LOGIC;
           reset         : in STD_LOGIC;
           i_global_x    : in STD_LOGIC_VECTOR (9 downto 0);
           i_global_y    : in STD_LOGIC_VECTOR (9 downto 0);
           i_ch_tile_id  : in STD_LOGIC_VECTOR (5 downto 0);
           i_ch_tile_row : in STD_LOGIC_VECTOR (6 downto 0);
           i_ch_tile_col : in STD_LOGIC_VECTOR (6 downto 0);
           i_ch_en       : in STD_LOGIC;
           o_tile_id     : out STD_LOGIC_VECTOR (5 downto 0);
           o_tile_x      : out STD_LOGIC_VECTOR (2 downto 0);
           o_tile_y      : out STD_LOGIC_VECTOR (2 downto 0));
end background_buffer;

architecture Behavioral of background_buffer is

    type BackgroundBufferArray is array(127 downto 0, 127 downto 0) of STD_LOGIC_VECTOR (5 downto 0);
    
    signal s_buffer : BackgroundBufferArray := (others => (others => (others => '0'))); 
    
    signal s_new_tile_row : UNSIGNED (6 downto 0);
    signal s_new_tile_col : UNSIGNED (6 downto 0);
    
    signal s_out_tile_id : STD_LOGIC_VECTOR (5 downto 0);
    signal s_out_tile_x  : STD_LOGIC_VECTOR (2 downto 0);
    signal s_out_tile_y  : STD_LOGIC_VECTOR (2 downto 0);
    
    signal s_tile_index_col : UNSIGNED (6 downto 0);
    signal s_tile_index_row : UNSIGNED (6 downto 0);
    
begin

    pro_clk_reset: process(clk, reset)
    begin
        if reset = '1' then
            s_buffer <= (others => (others => (others => '0')));        
        elsif rising_edge(clk) then
            o_tile_id <= s_out_tile_id;
            o_tile_x  <= s_out_tile_x;
            o_tile_y  <= s_out_tile_y;
            if i_ch_en = '1' then
                s_buffer(TO_INTEGER(s_new_tile_row), TO_INTEGER(s_new_tile_col)) <= i_ch_tile_id;
            end if;
        end if;
    end process;
    
    s_new_tile_row <= UNSIGNED(i_ch_tile_row);
    s_new_tile_col <= UNSIGNED(i_ch_tile_col);
    
    s_out_tile_x <= i_global_x(2 downto 0);
    s_out_tile_y <= i_global_y(2 downto 0);
    
    s_tile_index_col <= shift_right(UNSIGNED(i_global_x), 3)(6 downto 0);
    s_tile_index_row <= shift_right(UNSIGNED(i_global_y), 3)(6 downto 0);
    s_out_tile_id <= s_buffer(TO_INTEGER(s_tile_index_row), TO_INTEGER(s_tile_index_col));

    -- If there are weird problems with synchronization, comment the 3 lines on top and uncomment the one below
    -- s_out_tile_id <= s_buffer(TO_INTEGER(shift_right(UNSIGNED(i_global_y), 3)(6 downto 0)), TO_INTEGER(shift_right(UNSIGNED(i_global_x), 3)(6 downto 0)));

end Behavioral;
