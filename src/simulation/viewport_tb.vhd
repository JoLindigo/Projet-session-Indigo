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
        Port (
            i_print_px_y : in STD_LOGIC_VECTOR (9 downto 0);
            i_print_px_x : in STD_LOGIC_VECTOR (9 downto 0);
            i_offset_y   : in STD_LOGIC_VECTOR (9 downto 0);
            i_offset_x   : in STD_LOGIC_VECTOR (9 downto 0);
            o_global_x   : out STD_LOGIC_VECTOR (9 downto 0);
            o_global_y   : out STD_LOGIC_VECTOR (9 downto 0)
        );
    end component;
    
    -- Signals
    signal i_print_px_y, i_print_px_x : STD_LOGIC_VECTOR (9 downto 0);
    signal i_offset_y, i_offset_x : STD_LOGIC_VECTOR (9 downto 0);
    signal o_global_x, o_global_y : STD_LOGIC_VECTOR (9 downto 0);
    
    -- Constants
    constant SCREEN_WIDTH  : unsigned(9 downto 0) := to_unsigned(640, 10);
    constant SCREEN_HEIGHT : unsigned(9 downto 0) := to_unsigned(360, 10);
    
begin
    
    -- Instantiate the viewport module
    uut: viewport
        port map(
            i_print_px_y => i_print_px_y,
            i_print_px_x => i_print_px_x,
            i_offset_y   => i_offset_y,
            i_offset_x   => i_offset_x,
            o_global_x   => o_global_x,
            o_global_y   => o_global_y
        );
    
    -- Test process
    stim_proc: process
    begin
        
        -- Test Case 1: Normal Addition (within limits)
        i_print_px_x <= std_logic_vector(to_unsigned(400, 10));
        i_offset_x   <= std_logic_vector(to_unsigned(100, 10));
        i_print_px_y <= std_logic_vector(to_unsigned(200, 10));
        i_offset_y   <= std_logic_vector(to_unsigned(50, 10));
        wait for 10 ns;
        
        -- Test Case 2: Exceeding X limit
        i_print_px_x <= std_logic_vector(to_unsigned(600, 10));
        i_offset_x   <= std_logic_vector(to_unsigned(100, 10));
        i_print_px_y <= std_logic_vector(to_unsigned(200, 10));
        i_offset_y   <= std_logic_vector(to_unsigned(50, 10));
        wait for 10 ns;
        
        -- Test Case 3: Exceeding Y limit
        i_print_px_x <= std_logic_vector(to_unsigned(400, 10));
        i_offset_x   <= std_logic_vector(to_unsigned(100, 10));
        i_print_px_y <= std_logic_vector(to_unsigned(350, 10));
        i_offset_y   <= std_logic_vector(to_unsigned(20, 10));
        wait for 10 ns;
        
        -- Test Case 4: Exceeding Both Limits
        i_print_px_x <= std_logic_vector(to_unsigned(630, 10));
        i_offset_x   <= std_logic_vector(to_unsigned(50, 10));
        i_print_px_y <= std_logic_vector(to_unsigned(355, 10));
        i_offset_y   <= std_logic_vector(to_unsigned(10, 10));
        wait for 10 ns;
        
        -- End simulation
        wait;
        
    end process;
    
end Behavioral;