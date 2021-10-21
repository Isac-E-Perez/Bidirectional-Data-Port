library ieee;
use ieee.std_logic_1164.all;

entity biport_tb is 
end biport_tb;
  
architecture behavioral of biport_tb is
  component biport is
    port (
          send : in std_logic_vector(3 downto 0);
          occurrence : in std_logic;
          recieve : out std_logic_vector(3 downto 0); 
          data : inout std_logic_vector(3 downto 0) 
          );
  end component;

-- Input
signal send : std_logic_vector(3 downto 0) := (others => '0'); 
signal occurrence : std_logic := '0';

-- Output
signal recieve : out std_logic_vector(3 downto 0);

-- Inout
signal data : inout std_logic_vector(3 downto 0);

begin 
  uut: biport port map(send=>send, occurrence=>occurrence, recieve=>recieve, data=>data);
    
    stim_proc: process
    begin
      
      data <= "ZZZZ"; wait for 100 ns;
      occurrence <= '0'; send <= x"A"; Data <= "ZZZZ"; wait for 20 ns;
      occurrence <= '1'; data <= x"E"; wait for 20 ns;
      occurrence <= '0'; send <= x"9"; Data <= "ZZZZ"; wait for 20 ns;
      occurrence <= '1'; send <= x"3"; wait for 20 ns;
                         data <= x"C"; 
      
      assert false report "Reached end of test";
      wait;
    end process;
end behavioral;
    
