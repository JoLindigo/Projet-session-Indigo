----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2025 02:14:49 PM
-- Design Name: 
-- Module Name: controller - Behavioral
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

entity controller is
  Port (
    i_instruction: in std_logic_vector(31 downto 0); -- 4 bits opcode
    i_clk: in std_logic;
    i_reset: in std_logic;
    o_ch_offset_x: out std_logic_vector(9 downto 0);
    o_ch_offset_y: out std_logic_vector(9 downto 0);
    o_ch_tile_id: out std_logic_vector(5 downto 0);
    o_ch_tile_row: out std_logic_vector(6 downto 0);
    o_ch_tile_col: out std_logic_vector(6 downto 0);
    o_ch_tile_id_en: out std_logic;
    o_ch_tile_color: out std_logic_vector(4 downto 0);
    o_ch_tile_x: out std_logic_vector(2 downto 0);
    o_ch_tile_y: out std_logic_vector(2 downto 0);
    o_global_actor_en: out std_logic;
    o_actor_buffer_en: out std_logic;
    o_ch_tile_color_en: out std_logic;
    o_bg_tile_en: out std_logic;
    o_pos_en: out std_logic
  );
end controller;

architecture Behavioral of controller is

begin

process(i_clk, i_reset, i_instruction)
begin 
    if(i_reset = '0' and rising_edge(clk)) then
        o_ch_offset_x <= (others => '0');
        o_ch_offset_y <= (others => '0');
        o_ch_tile_id <= (others => '0');
        o_ch_tile_row <= (others => '0');
        o_ch_tile_col <= (others => '0');
        o_ch_tile_id_en <= '1';
        o_ch_tile_color <= (others => '0');
        o_ch_tile_x <= (others => '0');
        o_ch_tile_y <= (others => '0');
        o_global_actor_en <= '0';
        o_actor_buffer_en <= '0';
        o_ch_tile_color_en <= '0';
        o_bg_tile_en <= '0';
        o_pos_en <= '0';
        
        case i_instruction(31 downto 28) is
            when "0000" =>                  -- SET_ACTOR_TILE_BUFFER_ID
                o_ch_tile_id <= i_instruction(27 downto 22);
                o_ch_tile_x <= i_instruction(21 downto 19);
                o_ch_tile_y <= i_instruction(18 downto 16);
                o_ch_tile_color <= i_instruction(15 downto 12);
                o_actor_buffer_en <= '1';
            when "0001" =>    -- SET_BG_TILE_BUFFER_ID
                o_ch_tile_id <= i_instruction(27 downto 22);
                o_ch_tile_x <= i_instruction(21 downto 19);
                o_ch_tile_y <= i_instruction(18 downto 16);
                o_ch_tile_color <= i_instruction(15 downto 12);
                o_ch_tile_color_en <= '1';
            when "0010" =>      -- SET_ACTOR_TILE_ID
                o_ch_tile_id <= i_instruction(27 downto 22);
                o_ch_tile_id_en <= '1';
            when "0011" =>             -- SET_BG_TILE_ID
                o_ch_tile_id <= i_instruction(27 downto 22);
                o_ch_tile_row <= i_instruction(21 downto 19);
                o_ch_tile_col <= i_instruction(18 downto 16);
                o_ch_tile_id_en <= '1';
            when "0100" =>                  -- MOVE_ACTOR_RELATIVE
                o_ch_tile_id <= i_instruction(27 downto 22);
                o_ch_offset_x <= i_instruction(21 downto 12);
                o_ch_offset_y <= i_instruction(11 downto 3);
                o_pos_en <= '1';
                o_ch_tile_id_en <= '1';
                o_bg_tile_en <= '1';
            when "0101" =>                  -- MOVE_ACTOR_ABSOLUTE
                o_ch_tile_id <= i_instruction(27 downto 22);
                o_ch_offset_x <= i_instruction(21 downto 12);
                o_ch_offset_y <= i_instruction(11 downto 3);
                o_global_actor_en <= '1';
                o_pos_en <= '1';
                o_ch_tile_id_en <= '1';
           when "0110" =>                   -- SET_OFFSET
                o_ch_offset_x <= i_instruction(21 downto 12);
                o_ch_offset_y <= i_instruction(11 downto 3);
                o_global_actor_en <= '1';
                o_ch_tile_id_en <= '1';

           when others =>
                o_ch_offset_x <= (others => '0');
                o_ch_offset_y <= (others => '0');
                o_ch_tile_id <= (others => '0');
                o_ch_tile_row <= (others => '0');
                o_ch_tile_col <= (others => '0');
                o_ch_tile_id_en <= '1';
                o_ch_tile_color <= (others => '0');
                o_ch_tile_x <= (others => '0');
                o_ch_tile_y <= (others => '0');
                o_global_actor_en <= '0';
                o_actor_buffer_en <= '0';
                o_ch_tile_color_en <= '0';
                o_bg_tile_en <= '0';
                o_pos_en <= '0';
        end case;
    end if;
end process;

end Behavioral;
