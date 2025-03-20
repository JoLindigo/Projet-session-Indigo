----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2025 02:00:35 AM
-- Design Name: 
-- Module Name: adder_12bits - Behavioral
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

entity adder_12bits is
    Port ( A : in STD_LOGIC_VECTOR (0 to 11);
           B : in STD_LOGIC_VECTOR (0 to 11);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (0 to 11);
           Cout : out STD_LOGIC);
end adder_12bits;

architecture Behavioral of adder_12bits is
    signal temp : std_logic_vector(12 downto 0);
begin
    adder: process(A, B, Cin)
    begin
        temp <= A + B + Cin;
        
    end process;
end Behavioral;
