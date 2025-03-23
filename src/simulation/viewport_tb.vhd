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

entity viewport_tb is
end viewport_tb;

architecture Behavioral of viewport_tb is
    
    -- Component declaration
    component viewport
        Port ( i_clk            : in std_logic;
               i_reset          : in std_logic;
               i_print_px_y     : in STD_LOGIC_VECTOR (11 downto 0);
               i_print_px_x     : in STD_LOGIC_VECTOR (11 downto 0);
               i_offset_y       : in STD_LOGIC_VECTOR (9 downto 0);
               i_offset_x       : in STD_LOGIC_VECTOR (9 downto 0);
               i_ch_offset_en   : in std_logic;
               o_global_x       : out STD_LOGIC_VECTOR (11 downto 0);
               o_global_y       : out STD_LOGIC_VECTOR (11 downto 0));
    end component;
    
    -- Signals
    signal i_print_px_y, i_print_px_x : STD_LOGIC_VECTOR (11 downto 0);
    signal i_offset_y, i_offset_x : STD_LOGIC_VECTOR (9 downto 0);
    signal o_global_x, o_global_y : STD_LOGIC_VECTOR (11 downto 0);
    signal i_clk, i_reset, i_ch_offset_en: STD_LOGIC;
    
--    -- Constants
--    constant SCREEN_WIDTH  : unsigned(9 downto 0) := to_unsigned(640, 10);
--    constant SCREEN_HEIGHT : unsigned(9 downto 0) := to_unsigned(360, 10);
    
    constant PERIOD         : time :=  13.531531 ns;
    constant COMMAND_PERIOD : time :=  50 ns;
    
begin
    
    -- Instantiate the viewport module
    uut: viewport
        port map(
           i_clk            => i_clk,
           i_reset          => i_reset,
           i_print_px_y     => i_print_px_y,
           i_print_px_x     => i_print_px_x,
           i_offset_y       => i_offset_y,
           i_offset_x       => i_offset_x,
           i_ch_offset_en   => i_ch_offset_en,
           o_global_x       => o_global_x,
           o_global_y       => o_global_y    
        );
    sim_clk_p: process
        begin
          i_clk <= '1';
          loop
             wait for PERIOD / 2;
             i_clk <= not i_clk;
          end loop;
    end process;
    
    -- Test process
    stim_proc: process
    begin
        i_reset <= '0';
        
        -- Test Case 1: Normal Addition (within limits)
        i_print_px_x    <= std_logic_vector(to_unsigned(800, 12));
        i_offset_x      <= std_logic_vector(to_unsigned(100, 10));
        i_print_px_y    <= std_logic_vector(to_unsigned(700, 12));
        i_offset_y      <= std_logic_vector(to_unsigned(50, 10));
        i_ch_offset_en  <= '1';
        wait for COMMAND_PERIOD;
        
        -- Test Case 2: Exceeding X limit
        i_print_px_x    <= std_logic_vector(to_unsigned(800, 12));
        i_offset_x      <= std_logic_vector(to_unsigned(600, 10));
        i_print_px_y    <= std_logic_vector(to_unsigned(700, 12));
        i_offset_y      <= std_logic_vector(to_unsigned(50, 10));
        i_ch_offset_en  <= '1';
        wait for COMMAND_PERIOD;
        
        -- Test Case 3: Exceeding Y limit
        i_print_px_x    <= std_logic_vector(to_unsigned(800, 12));
        i_offset_x      <= std_logic_vector(to_unsigned(100, 10));
        i_print_px_y    <= std_logic_vector(to_unsigned(700, 12));
        i_offset_y      <= std_logic_vector(to_unsigned(900, 10));
        i_ch_offset_en  <= '1';
        wait for COMMAND_PERIOD;
        
        -- Test Case 4: Exceeding Both Limits
        i_print_px_x    <= std_logic_vector(to_unsigned(800, 12));
        i_offset_x      <= std_logic_vector(to_unsigned(600, 10));
        i_print_px_y    <= std_logic_vector(to_unsigned(700, 12));
        i_offset_y      <= std_logic_vector(to_unsigned(900, 10));
        i_ch_offset_en  <= '1';
        wait for COMMAND_PERIOD;
        
        -- End simulation
        wait;
        
    end process;
    
end Behavioral;