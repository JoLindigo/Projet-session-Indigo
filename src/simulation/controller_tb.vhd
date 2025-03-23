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

entity controller_tb is
end controller_tb;

architecture Behavioral of controller_tb is
component controller is
  Port (
    i_instruction                   : in std_logic_vector(31 downto 0); -- 4 bits opcode
    i_clk                           : in std_logic;
    i_reset                         : in std_logic;
    
    o_bg_buffer_ch_tile_id          : out std_logic_vector(5 downto 0);
    o_bg_buffer_ch_tile_row         : out std_logic_vector(6 downto 0);
    o_bg_buffer_ch_tile_col         : out std_logic_vector(6 downto 0);
    o_bg_buffer_ch_en               : out std_logic;
    
    o_bg_tile_buffer_ch_pixel_color : out std_logic_vector(4 downto 0);
    o_bg_tile_buffer_ch_tile_x      : out std_logic_vector(2 downto 0);
    o_bg_tile_buffer_ch_tile_y      : out std_logic_vector(2 downto 0);
    o_bg_tile_buffer_ch_tile_id     : out std_logic_vector(5 downto 0); 
    o_bg_tile_buffer_ch_en          : out std_logic;  
    
    o_ch_viewport_offset_x          : out std_logic_vector(9 downto 0);
    o_ch_viewport_offset_y          : out std_logic_vector(9 downto 0); 
    o_ch_viewport_en                : out std_logic;
    
    o_global_reset                  : out std_logic
  );
end component;

constant OPCODE_NOP                     : std_logic_vector(3 downto 0) := "0000";
constant OPCODE_SETACTORTILECOLOR       : std_logic_vector(3 downto 0) := "0001";
constant OPCODE_SETBACKGROUNDTILECOLOR  : std_logic_vector(3 downto 0) := "0010";
constant OPCODE_SETACTORTILEID          : std_logic_vector(3 downto 0) := "0011";
constant OPCODE_SETBACKGROUNDTILEID     : std_logic_vector(3 downto 0) := "0100";
constant OPCODE_MOVEACTORPOSITION       : std_logic_vector(3 downto 0) := "0101";
constant OPCODE_SETACTORPOSITION        : std_logic_vector(3 downto 0) := "0110";
constant OPCODE_SETVIEWPORTOFFSET       : std_logic_vector(3 downto 0) := "0111";
constant OPCODE_GLOBALRESET             : std_logic_vector(3 downto 0) := "1111";

--Simulation Signals
signal i_instruction                   : std_logic_vector(31 downto 0);
signal i_clk                           : std_logic;
signal i_reset                         : std_logic;

signal o_bg_buffer_ch_tile_id          : std_logic_vector(5 downto 0);
signal o_bg_buffer_ch_tile_row         : std_logic_vector(6 downto 0);
signal o_bg_buffer_ch_tile_col         : std_logic_vector(6 downto 0);
signal o_bg_buffer_ch_en               : std_logic;

signal o_bg_tile_buffer_ch_pixel_color : std_logic_vector(4 downto 0);
signal o_bg_tile_buffer_ch_tile_x      : std_logic_vector(2 downto 0);
signal o_bg_tile_buffer_ch_tile_y      : std_logic_vector(2 downto 0);
signal o_bg_tile_buffer_ch_tile_id     : std_logic_vector(5 downto 0); 
signal o_bg_tile_buffer_ch_en          : std_logic;  

signal o_ch_viewport_offset_x          : std_logic_vector(9 downto 0);
signal o_ch_viewport_offset_y          : std_logic_vector(9 downto 0); 
signal o_ch_viewport_en                : std_logic;

signal o_global_reset                  : std_logic;
    
constant PERIOD         : time :=  13.531531 ns;
constant COMMAND_PERIOD : time :=  50 ns;

begin
    UUT: controller
        Port map( 
            i_instruction                   => i_instruction,                  
            i_clk                           => i_clk,                          
            i_reset                         => i_reset,                        
        
            o_bg_buffer_ch_tile_id          => o_bg_buffer_ch_tile_id,         
            o_bg_buffer_ch_tile_row         => o_bg_buffer_ch_tile_row,        
            o_bg_buffer_ch_tile_col         => o_bg_buffer_ch_tile_col,        
            o_bg_buffer_ch_en               => o_bg_buffer_ch_en,              
        
            o_bg_tile_buffer_ch_pixel_color => o_bg_tile_buffer_ch_pixel_color,
            o_bg_tile_buffer_ch_tile_x      => o_bg_tile_buffer_ch_tile_x,     
            o_bg_tile_buffer_ch_tile_y      => o_bg_tile_buffer_ch_tile_y,     
            o_bg_tile_buffer_ch_tile_id     => o_bg_tile_buffer_ch_tile_id,    
            o_bg_tile_buffer_ch_en          => o_bg_tile_buffer_ch_en,         
        
            o_ch_viewport_offset_x          => o_ch_viewport_offset_x,         
            o_ch_viewport_offset_y          => o_ch_viewport_offset_y,         
            o_ch_viewport_en                => o_ch_viewport_en,               
        
            o_global_reset                  => o_global_reset);                 
            
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
        wait for COMMAND_PERIOD;
        i_instruction(31 downto 28) <= OPCODE_NOP;
        i_instruction(27 downto 0)  <= (others => '1');
        i_reset                     <= '0';
        
        wait for COMMAND_PERIOD;
        i_instruction(31 downto 28) <= OPCODE_SETBACKGROUNDTILECOLOR;
        i_instruction(27 downto 0)  <= (others => '1');
        i_reset                     <= '0';
        
        wait for COMMAND_PERIOD;
        i_instruction(31 downto 28) <= OPCODE_NOP;
        i_instruction(27 downto 0)  <= (others => '1');
        i_reset                     <= '0';
        
        wait for COMMAND_PERIOD;
        i_instruction(31 downto 28) <= OPCODE_SETBACKGROUNDTILEID;
        i_instruction(27 downto 0)  <= (others => '1');
        i_reset                     <= '0';
        
        wait for COMMAND_PERIOD;
        i_instruction(31 downto 28) <= OPCODE_NOP;
        i_instruction(27 downto 0)  <= (others => '1');
        i_reset                     <= '0';
        
        wait for COMMAND_PERIOD;
        i_instruction(31 downto 28) <= OPCODE_SETVIEWPORTOFFSET;
        i_instruction(27 downto 0)  <= (others => '1');
        i_reset                     <= '0';
        
        wait for COMMAND_PERIOD;
        i_instruction(31 downto 28) <= OPCODE_NOP;
        i_instruction(27 downto 0)  <= (others => '1');
        i_reset                     <= '0';
        
        wait for COMMAND_PERIOD;
        i_instruction(31 downto 28) <= OPCODE_GLOBALRESET;
        i_instruction(27 downto 0)  <= (others => '1');
        i_reset                     <= '0';
        
        WAIT;
   end process;

end Behavioral;
