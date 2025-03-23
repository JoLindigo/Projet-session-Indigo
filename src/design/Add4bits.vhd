----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2025 07:15:27 AM
-- Design Name: 
-- Module Name: Add4bits - Behavioral
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

entity Add4bits is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
           Y : in STD_LOGIC_VECTOR (3 downto 0);
           Ci : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Co : out STD_LOGIC);
end Add4bits;

architecture Behavioral of Add4bits is

    signal carry : std_logic_vector(3 downto 0);

begin

    carry(0) <= ci;
    
    -- Bit 0 : Add1BitA
    U0 : entity work.Add1bit
        port map (
            X => X(0),
            Y => Y(0),
            Ci => Ci,
            S => S(0),
            Co => carry(1)
        );
        
    -- Bit 1 : Add1BitA
    U1 : entity work.Add1bit
        port map (
            X => X(1),
            Y => Y(1),
            Ci => carry(1),
            S => S(1),
            Co => carry(2)
        );
        
    -- Bit 2 : Add1BitB
    U2 : entity work.Add1bit
        port map (
            X => X(2),
            Y => Y(2),
            Ci => carry(2),
            S => S(2),
            Co => carry(3)
        );
        
    -- Bit 3 : Add1BitB
    U3 : entity work.Add1bit
        port map (
            X => X(3),
            Y => Y(3),
            Ci => carry(3),
            S => S(3),
            Co => Co
        );
        

end Behavioral;
