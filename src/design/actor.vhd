----------------------------------------------------------------------------------
-- Company: joledingo
-- Engineer: pickle
-- 
-- Create Date: 03/07/2025 06:52:13 PM
-- Design Name: 
-- Module Name: actor - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity actor is
    port (
        -- Inputs: 
        i_clk             : in  std_logic;
        -- Global actor position (top-left)
        i_global_actor_x  : in  std_logic_vector(9 downto 0);
        i_global_actor_y  : in  std_logic_vector(9 downto 0);
        -- Current pixel position being printed
        i_print_px_x      : in  std_logic_vector(9 downto 0);
        i_print_px_y      : in  std_logic_vector(9 downto 0);
        -- Tile id change
        i_change_tile_id  : in  std_logic_vector(5 downto 0);
        -- Movement signals
        i_move_actor_x    : in  std_logic_vector(3 downto 0);
        i_move_actor_y    : in  std_logic_vector(3 downto 0);
        -- Enable signals for updating tile id, global position, and movement
        i_ch_tile_id_en   : in  std_logic;
        i_global_actor_en : in  std_logic;
        i_move_actor_en   : in  std_logic;
        -- Enable this inst of actor
        i_actor_en        : in  std_logic;
        -- Outputs: tile id to display and relative pixel coordinates within the tile
        o_tile_id       : out std_logic_vector(5 downto 0);
        o_tile_x        : out std_logic_vector(3 downto 0);
        o_tile_y        : out std_logic_vector(3 downto 0)
    );
end actor;

architecture Behavioral of actor is
    
    -- Internal registers to store the actor's current position and current tile id
    signal actor_x : std_logic_vector(9 downto 0) := (others => '0');
    signal actor_y : std_logic_vector(9 downto 0) := (others => '0');
    signal tile_reg : std_logic_vector(5 downto 0) := (others => '0');

begin

    -- Update the actor's state on the rising edge of the clock
    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_actor_en = '1' then
                -- Si global position update is enabled, update absolute position of actor
                if i_global_actor_en = '1' then
                    actor_x <= i_global_actor_x;
                    actor_y <= i_global_actor_y;
                -- Else, if move is enabled, update the position by adding offsets
                elsif i_move_actor_en = '1' then
                    actor_x <= std_logic_vector(unsigned(actor_x) + unsigned(i_move_actor_x));
                    actor_y <= std_logic_vector(unsigned(actor_y) + unsigned(i_move_actor_y));
                end if;
                -- Update tile id if change enable is active
                if i_ch_tile_id_en = '1' then
                    tile_reg <= i_change_tile_id;
                end if;
            end if;
        end if;
    end process;
    
    -- Calculate outputs based on the current print pixel and actor position
    process(i_print_px_x, i_print_px_y, actor_x, actor_y, tile_reg)
        variable diff_x : unsigned(9 downto 0);
        variable diff_y : unsigned(9 downto 0);
    begin
        -- Check if current print pixel is within the 16x16 area of the actor
        if (unsigned(i_print_px_x) >= unsigned(actor_x)) and 
           (unsigned(i_print_px_x) < unsigned(actor_x) + 16) and
           (unsigned(i_print_px_y) >= unsigned(actor_y)) and 
           (unsigned(i_print_px_y) < unsigned(actor_y) + 16) then
           
           -- Compute the difference to get the relative coordinates
            diff_x := unsigned(i_print_px_x) - unsigned(actor_x);
            diff_y := unsigned(i_print_px_y) - unsigned(actor_y);
            
            o_tile_x <= std_logic_vector(diff_x(3 downto 0));
            o_tile_y <= std_logic_vector(diff_y(3 downto 0));
            o_tile_id <= tile_reg;
            
        else
            -- Outside the actor's area: output default values
            o_tile_x <= (others => '0');
            o_tile_y <= (others => '0');
            o_tile_id <= (others => '0');
        end if;
    end process;


end Behavioral;
