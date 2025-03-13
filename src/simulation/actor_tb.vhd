----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2025 07:37:56 PM
-- Design Name: 
-- Module Name: actor_tb - Behavioral
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity actor_tb is
end actor_tb;

architecture Behavioral of actor_tb is

    component actor
        port (
            i_clk             : in  std_logic;
            i_global_actor_x  : in  std_logic_vector(9 downto 0);
            i_global_actor_y  : in  std_logic_vector(9 downto 0);
            i_print_px_x      : in  std_logic_vector(9 downto 0);
            i_print_px_y      : in  std_logic_vector(9 downto 0);
            i_change_tile_id  : in  std_logic_vector(5 downto 0);
            i_move_actor_x    : in  std_logic_vector(3 downto 0);
            i_move_actor_y    : in  std_logic_vector(3 downto 0);
            i_ch_tile_id_en   : in  std_logic;
            i_global_actor_en : in  std_logic;
            i_move_actor_en   : in  std_logic;
            i_actor_en        : in  std_logic;
            o_tile_id       : out std_logic_vector(5 downto 0);
            o_tile_x        : out std_logic_vector(3 downto 0);
            o_tile_y        : out std_logic_vector(3 downto 0)
        );
    end component;

    signal i_clk             : std_logic := '0';
    signal i_global_actor_x  : std_logic_vector(9 downto 0) := (others => '0');
    signal i_global_actor_y  : std_logic_vector(9 downto 0) := (others => '0');
    signal i_print_px_x      : std_logic_vector(9 downto 0) := (others => '0');
    signal i_print_px_y      : std_logic_vector(9 downto 0) := (others => '0');
    signal i_change_tile_id  : std_logic_vector(5 downto 0) := (others => '0');
    signal i_move_actor_x    : std_logic_vector(3 downto 0) := (others => '0');
    signal i_move_actor_y    : std_logic_vector(3 downto 0) := (others => '0');
    signal i_ch_tile_id_en   : std_logic := '0';
    signal i_global_actor_en : std_logic := '0';
    signal i_move_actor_en   : std_logic := '0';
    signal i_actor_en        : std_logic := '0';
    signal o_tile_id         : std_logic_vector(5 downto 0);
    signal o_tile_x          : std_logic_vector(3 downto 0);
    signal o_tile_y          : std_logic_vector(3 downto 0);

    -- Clock generation
    constant clk_period : time := 10 ns;
    signal stop_sim : boolean := false;

begin
    uut: actor
        port map (
            i_clk             => i_clk,
            i_global_actor_x  => i_global_actor_x,
            i_global_actor_y  => i_global_actor_y,
            i_print_px_x      => i_print_px_x,
            i_print_px_y      => i_print_px_y,
            i_change_tile_id  => i_change_tile_id,
            i_move_actor_x    => i_move_actor_x,
            i_move_actor_y    => i_move_actor_y,
            i_ch_tile_id_en   => i_ch_tile_id_en,
            i_global_actor_en => i_global_actor_en,
            i_move_actor_en   => i_move_actor_en,
            i_actor_en        => i_actor_en,
            o_tile_id         => o_tile_id,
            o_tile_x          => o_tile_x,
            o_tile_y          => o_tile_y
        );

    -- Clock process
    process
    begin
        while not stop_sim loop
            i_clk <= '0';
            wait for clk_period / 2;
            i_clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    process
    begin
        i_actor_en <= '1';
        
        i_global_actor_x <= std_logic_vector(to_unsigned(100, 10));
        i_global_actor_y <= std_logic_vector(to_unsigned(50, 10));
        i_global_actor_en <= '1';
        wait for clk_period;
        i_global_actor_en <= '0';
        
        i_change_tile_id <= "000101";
        i_ch_tile_id_en <= '1';
        wait for clk_period;
        i_ch_tile_id_en <= '0';
        
        i_print_px_x <= std_logic_vector(to_unsigned(105, 10));
        i_print_px_y <= std_logic_vector(to_unsigned(55, 10));
        wait for clk_period;
        
        i_print_px_x <= std_logic_vector(to_unsigned(200, 10));
        i_print_px_y <= std_logic_vector(to_unsigned(200, 10));
        wait for clk_period;
        
        i_move_actor_x <= "0010";
        i_move_actor_y <= "0011";
        i_move_actor_en <= '1';
        wait for clk_period;
        i_move_actor_en <= '0';
        
        i_print_px_x <= std_logic_vector(to_unsigned(105, 10));
        i_print_px_y <= std_logic_vector(to_unsigned(55, 10));
        wait for clk_period;
        
        stop_sim <= true;
        wait;
    end process;

end Behavioral;