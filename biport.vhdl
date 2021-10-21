library ieee;
use ieee.std_logic_1164.all;

entity biport is
  port (
        send : in std_logic_vector(3 downto 0);
        occurrence : in std_logic;
        recieve : out std_logic_vector(3 downto 0); 
        data : inout std_logic_vecotr(3 downto 0) 
        );
end biport;
  
architecture behavioral of biport is
  
begin
    data <= send when occurrence = '0' else (others => 'Z');
    recieve <= data when occurrence = '1' else (others => 'Z');
end behavioral;  
