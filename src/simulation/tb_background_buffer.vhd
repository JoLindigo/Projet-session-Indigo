----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/05/2025 12:47:28 PM
-- Design Name: 
-- Module Name: tb_background_buffer - Behavioral
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

entity tb_background_buffer is
--  Port ( );
end tb_background_buffer;

architecture Behavioral of tb_background_buffer is

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
    
    signal s_clk         : STD_LOGIC;
    signal s_reset       : STD_LOGIC;
    signal s_global_x    : STD_LOGIC_VECTOR (9 downto 0);
    signal s_global_y    : STD_LOGIC_VECTOR (9 downto 0);
    signal s_ch_tile_id  : STD_LOGIC_VECTOR (5 downto 0);
    signal s_ch_tile_row : STD_LOGIC_VECTOR (6 downto 0);
    signal s_ch_tile_col : STD_LOGIC_VECTOR (6 downto 0);
    signal s_ch_en       : STD_LOGIC;
    signal s_tile_id     : STD_LOGIC_VECTOR (5 downto 0);
    signal s_tile_x      : STD_LOGIC_VECTOR (2 downto 0);
    signal s_tile_y      : STD_LOGIC_VECTOR (2 downto 0);
    
    CONSTANT CLK_PERIOD : time := 13.53ns;
    CONSTANT DELAY_BETWEEN_TESTS : time := 25ns;

begin

    pro_sim_clk: process
    begin
        s_clk <= '1';
        loop
            wait for CLK_PERIOD / 2;
            s_clk <= not s_clk;
        end loop;
    end process;

    inst_background_buffer : background_buffer
        Port map (
            clk => s_clk,
            reset => s_reset,
            i_global_x => s_global_x,
            i_global_y => s_global_y,
            i_ch_tile_id => s_ch_tile_id,
            i_ch_tile_row => s_ch_tile_row,
            i_ch_tile_col => s_ch_tile_col,
            i_ch_en => s_ch_en,
            o_tile_id => s_tile_id,
            o_tile_x => s_tile_x,
            o_tile_y => s_tile_y
        );
        
    pro_sim_background_buffer: process
    begin
        s_reset    <= '1';
        s_global_x <= "0000000000";
        s_global_y <= "0000000000";
        wait for DELAY_BETWEEN_TESTS;
        
        ---------------------------------------
        -- Tests for new tile id assignments --
        ---------------------------------------
        -- Change first tile (Top left) to ID 1
        s_reset <= '0';
        s_ch_tile_id  <= "000001";
        s_ch_tile_row <= "0000000";
        s_ch_tile_col <= "0000000";
        s_ch_en <= '1';
        wait for DELAY_BETWEEN_TESTS;
        s_ch_en <= '0';
        
        -- Change last tile (Bottom right) to ID 63
        s_reset <= '0';
        s_ch_tile_id  <= "111111";
        s_ch_tile_row <= "1111111";
        s_ch_tile_col <= "1111111";
        s_ch_en <= '1';
        wait for DELAY_BETWEEN_TESTS;
        s_ch_en <= '0';        
        
        -- Change random tile (x: 79, y: 31) to ID 15
        s_reset <= '0';
        s_ch_tile_id  <= "001111";
        s_ch_tile_row <= "0011111";
        s_ch_tile_col <= "1001111";
        s_ch_en <= '1';
        wait for DELAY_BETWEEN_TESTS;
        s_ch_en <= '0';                
        
        -----------------------------------------
        -- Tests with inputs from the viewport --
        -----------------------------------------
        -- First tile (Top left) with pixel at 0, 0
        s_global_x <= "0000000000";
        s_global_y <= "0000000000";
        wait for DELAY_BETWEEN_TESTS;
        
        -- First tile (Top left) with bottom right pixel at 7, 7
        s_global_x <= "0000000111";
        s_global_y <= "0000000111";
        wait for DELAY_BETWEEN_TESTS;        
        
        -- Last tile (Bottom right) with pixel at 0, 0
        s_global_x <= "1111111000";
        s_global_y <= "1111111000";
        wait for DELAY_BETWEEN_TESTS;

        -- Last tile (Bottom right) with pixel at 7, 7
        s_global_x <= "1111111111";
        s_global_y <= "1111111111";
        wait for DELAY_BETWEEN_TESTS; 
        
        -- Random tile (x: 79, y: 31) with random pixel
        s_global_x <= "1001111010";
        s_global_y <= "0011111000";
        wait for DELAY_BETWEEN_TESTS;                
        
        -- Random tile (x: 14, y: 57) with random pixel
        s_global_x <= "0001110100";
        s_global_y <= "0111001011";
        wait for DELAY_BETWEEN_TESTS;            
        
        wait;
        
    end process;
    
end Behavioral;
