----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2025 12:21:02 PM
-- Design Name: 
-- Module Name: color_mux - Behavioral
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

entity color_mux is
    Port ( i_sel : in STD_LOGIC_VECTOR (4 downto 0);
           o_color_rbg : out STD_LOGIC_VECTOR (23 downto 0));
end color_mux;

architecture Behavioral of color_mux is
    constant COLOR0 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR1 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR2 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR3 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR4 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR5 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR6 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR7 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR8 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR9 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR10 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR11 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR12 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR13 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR14 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR15 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR16 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR17 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR18 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR19 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR20 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR21 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR22 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR23 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR24 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR25 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR26 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR27 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR28 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR29 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR30 : std_logic_vector(23 downto 0) := x"000000";
    constant COLOR31 : std_logic_vector(23 downto 0) := x"000000";
begin
    mux : process(i_sel) is
    begin
        case i_sel is
            when "00000" => o_color_rbg <= COLOR0;
            when "00001" => o_color_rbg <= COLOR1;
            when "00010" => o_color_rbg <= COLOR2;
            when "00011" => o_color_rbg <= COLOR3;
            when "00100" => o_color_rbg <= COLOR4;
            when "00101" => o_color_rbg <= COLOR5;
            when "00110" => o_color_rbg <= COLOR6;
            when "00111" => o_color_rbg <= COLOR7;
            when "01000" => o_color_rbg <= COLOR8;
            when "01001" => o_color_rbg <= COLOR9;
            when "01010" => o_color_rbg <= COLOR10;
            when "01011" => o_color_rbg <= COLOR11;
            when "01100" => o_color_rbg <= COLOR12;
            when "01101" => o_color_rbg <= COLOR13;
            when "01110" => o_color_rbg <= COLOR14;
            when "01111" => o_color_rbg <= COLOR15;
            when "10000" => o_color_rbg <= COLOR16;
            when "10001" => o_color_rbg <= COLOR17;
            when "10010" => o_color_rbg <= COLOR18;
            when "10011" => o_color_rbg <= COLOR19;
            when "10100" => o_color_rbg <= COLOR20;
            when "10101" => o_color_rbg <= COLOR21;
            when "10110" => o_color_rbg <= COLOR22;
            when "10111" => o_color_rbg <= COLOR23;
            when "11000" => o_color_rbg <= COLOR24;
            when "11001" => o_color_rbg <= COLOR25;
            when "11010" => o_color_rbg <= COLOR26;
            when "11011" => o_color_rbg <= COLOR27;
            when "11100" => o_color_rbg <= COLOR28;
            when "11101" => o_color_rbg <= COLOR29;
            when "11110" => o_color_rbg <= COLOR30;
            when "11111" => o_color_rbg <= COLOR31;
            when others => o_color_rbg  <= "000000000000000000000000";
        end case;
    end process;
end Behavioral;
