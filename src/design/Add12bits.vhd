----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2025 02:00:35 AM
-- Design Name: 
-- Module Name: Add12bits - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 12-bit Adder
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

entity Add12bits is
    Port ( X : in STD_LOGIC_VECTOR (11 downto 0);  -- Correction : 11 downto 0
           Y : in STD_LOGIC_VECTOR (11 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (11 downto 0);
           Cout : out STD_LOGIC);
end Add12bits;

architecture Behavioral of Add12bits is
    signal carry : std_logic_vector(3 downto 0);
begin
    carry(0) <= Cin;
    
    -- Correction des indices en "downto"
    U0 : entity work.Add4bits
        port map (
            X => X(3 downto 0),
            Y => Y(3 downto 0),
            Ci => Cin,
            S => Sum(3 downto 0),
            Co => carry(1)
        );

    U1 : entity work.Add4bits
        port map (
            X => X(7 downto 4),
            Y => Y(7 downto 4),
            Ci => carry(1),
            S => Sum(7 downto 4),  -- Correction ici (7 downto 4 au lieu de 7 downto 3)
            Co => carry(2)
        );

    U2 : entity work.Add4bits
        port map (
            X => X(11 downto 8),
            Y => Y(11 downto 8),
            Ci => carry(2),
            S => Sum(11 downto 8), -- Correction ici aussi (11 downto 8 au lieu de 7 downto 3)
            Co => Cout
        );

end Behavioral;
