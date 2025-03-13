----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2025 12:57:43
-- Design Name: 
-- Module Name: bg_tile_buffer_tb - Behavioral
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

entity actor_tile_buffer_tb is
end actor_tile_buffer_tb;

architecture Behavioral of actor_tile_buffer_tb is
component actor_tile_buffer is
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
end component;

signal i_tile_id : STD_LOGIC_VECTOR (5 downto 0);
signal i_tile_x : STD_LOGIC_VECTOR (3 downto 0);
signal i_tile_y : STD_LOGIC_VECTOR (3 downto 0);
signal i_ch_tile_pixel_color : STD_LOGIC_VECTOR (4 downto 0);
signal i_ch_tile_x : STD_LOGIC_VECTOR (3 downto 0);
signal i_ch_tile_y : STD_LOGIC_VECTOR (3 downto 0);
signal i_ch_tile_id : STD_LOGIC_VECTOR (5 downto 0);
signal i_ch_en : STD_LOGIC;
signal i_reset : STD_LOGIC;
signal i_clk: STD_LOGIC;
signal o_color_code : STD_LOGIC_VECTOR (4 downto 0);

constant PERIOD         : time :=  13.531531 ns;
constant COMMAND_PERIOD : time :=  50 ns;

begin
    UUT: actor_tile_buffer
        Port map( 
            i_tile_id => i_tile_id,
            i_tile_x => i_tile_x,
            i_tile_y => i_tile_y,
            i_ch_tile_pixel_color => i_ch_tile_pixel_color,
            i_ch_tile_x => i_ch_tile_x,
            i_ch_tile_y => i_ch_tile_y,
            i_ch_tile_id => i_ch_tile_id,
            i_ch_en => i_ch_en,
            i_reset => i_reset,
            i_clk => i_clk,
            o_color_code => o_color_code);
    
   sim_clk_p: process
   begin
      i_clk <= '1';
      loop
         wait for PERIOD / 2;
         i_clk <= not i_clk;
      end loop;
   end process;
   
   tb: process
   begin
        wait for COMMAND_PERIOD; --Load value arr(0,0,0)
        i_tile_id <= "000001";
        i_tile_x <= "0001";
        i_tile_y <= "0001";
        i_ch_tile_pixel_color <= "11111";
        i_ch_tile_x <= "0000";
        i_ch_tile_y <= "0000";
        i_ch_tile_id <= "000000";
        i_ch_en <= '1';
        i_reset <= '0';
        
        wait for COMMAND_PERIOD; --Load value arr(31,15,15)
        i_tile_id <= "000001";
        i_tile_x <= "0001";
        i_tile_y <= "0001";
        i_ch_tile_pixel_color <= "10101";
        i_ch_tile_x <= "1111";
        i_ch_tile_y <= "1111";
        i_ch_tile_id <= "011111";
        i_ch_en <= '1';
        i_reset <= '0';   
        
        wait for COMMAND_PERIOD; --Load value arr(16,5,4)
        i_tile_id <= "000001";
        i_tile_x <= "0001";
        i_tile_y <= "0001";
        i_ch_tile_pixel_color <= "01010";
        i_ch_tile_x <= "0101";
        i_ch_tile_y <= "0100";
        i_ch_tile_id <= "010000";
        i_ch_en <= '1';
        i_reset <= '0'; 
        
        wait for COMMAND_PERIOD; --Load value arr(10,10,11)
        i_tile_id <= "000001";
        i_tile_x <= "0001";
        i_tile_y <= "0001";
        i_ch_tile_pixel_color <= "01111";
        i_ch_tile_x <= "1010";
        i_ch_tile_y <= "1011";
        i_ch_tile_id <= "001010";
        i_ch_en <= '1';
        i_reset <= '0'; 
        
        wait for COMMAND_PERIOD; --Read value arr(0,0,0)
        i_tile_id <= "000000";
        i_tile_x <= "0000";
        i_tile_y <= "0000";
        i_ch_tile_pixel_color <= (others => '0');
        i_ch_tile_x <= "0000";
        i_ch_tile_y <= "0000";
        i_ch_tile_id <= "000000";
        i_ch_en <= '0';
        i_reset <= '0';  
        
        wait for COMMAND_PERIOD; --Read value arr(31,15,15)
        i_tile_id <= "011111";
        i_tile_x <= "1111";
        i_tile_y <= "1111";
        i_ch_tile_pixel_color <= (others => '0');
        i_ch_tile_x <= "0000";
        i_ch_tile_y <= "0000";
        i_ch_tile_id <= "000000";
        i_ch_en <= '0';
        i_reset <= '0';   
        
        wait for COMMAND_PERIOD; --Read value arr(16,5,4)
        i_tile_id <= "010000";
        i_tile_x <= "0101";
        i_tile_y <= "0100";
        i_ch_tile_pixel_color <= (others => '0');
        i_ch_tile_x <= "0000";
        i_ch_tile_y <= "0000";
        i_ch_tile_id <= "000000";
        i_ch_en <= '0';
        i_reset <= '0';  
        
        wait for COMMAND_PERIOD; --Read value arr(10,10,11)
        i_tile_id <= "001010";
        i_tile_x <= "1010";
        i_tile_y <= "1011";
        i_ch_tile_pixel_color <= (others => '0');
        i_ch_tile_x <= "0000";
        i_ch_tile_y <= "0000";
        i_ch_tile_id <= "000000";
        i_ch_en <= '0';
        i_reset <= '0';    
        
        WAIT;
   end process;

end Behavioral;
