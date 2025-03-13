----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.03.2025 14:30:55
-- Design Name: 
-- Module Name: datapath - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is
--  Port ( );
end datapath;

architecture Behavioral of datapath is

component background_buffer is
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
end component;

component bg_tile_buffer is
    Port ( i_tile_id : in STD_LOGIC_VECTOR (5 downto 0);
           i_tile_x : in STD_LOGIC_VECTOR (2 downto 0);
           i_tile_y : in STD_LOGIC_VECTOR (2 downto 0);
           i_ch_tile_pixel_color : in STD_LOGIC_VECTOR (4 downto 0);
           i_ch_tile_x : in STD_LOGIC_VECTOR (2 downto 0);
           i_ch_tile_y : in STD_LOGIC_VECTOR (2 downto 0);
           i_ch_tile_id : in STD_LOGIC_VECTOR (5 downto 0);
           i_ch_en : in STD_LOGIC;
           i_reset : in STD_LOGIC;
           i_clk: in STD_LOGIC;
           o_color_code : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component color_mux is
    Port ( i_sel : in STD_LOGIC_VECTOR (4 downto 0);
           o_color_rbg : out STD_LOGIC_VECTOR (23 downto 0));
end component;

--Signals
signal s_bg_tile_id : STD_LOGIC_VECTOR (5 downto 0);
signal s_bg_tile_x : STD_LOGIC_VECTOR (2 downto 0);
signal s_bg_tile_y : STD_LOGIC_VECTOR (2 downto 0);
signal s_bg_color_code : STD_LOGIC_VECTOR (4 downto 0);

signal s_color_rbg : STD_LOGIC_VECTOR (23 downto 0);

begin

inst_background_buffer : background_buffer
    Port map
         ( clk              => '0',
           reset            => '0',
           i_global_x       => (others => '0'),
           i_global_y       => (others => '0'),
           i_ch_tile_id     => (others => '0'),
           i_ch_tile_row    => (others => '0'),
           i_ch_tile_col    => (others => '0'),
           i_ch_en          => '0',
           o_tile_id        => s_bg_tile_id,
           o_tile_x         => s_bg_tile_x,
           o_tile_y         => s_bg_tile_y );

inst_bg_tile_buffer : bg_tile_buffer
    Port map
         ( i_tile_id                => s_bg_tile_id,
           i_tile_x                 => s_bg_tile_x,
           i_tile_y                 => s_bg_tile_y,
           i_ch_tile_pixel_color    => (others => '0'),
           i_ch_tile_x              => (others => '0'),
           i_ch_tile_y              => (others => '0'),
           i_ch_tile_id             => (others => '0'),
           i_ch_en                  => '0',
           i_reset                  => '0',
           i_clk                    => '0',
           o_color_code             => s_bg_color_code );
           
inst_color_mux : color_mux
    Port map
         ( i_sel        => s_bg_color_code,
           o_color_rbg  => s_color_rbg );

end Behavioral;
