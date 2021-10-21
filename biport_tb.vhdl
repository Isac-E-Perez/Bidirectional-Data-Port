library ieee;
use ieee.std_logic_1164.all;

entity biport_tb is 
end biport_tb;
  
architecture behavioral for biport_tb is
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
signal occurrence std_logic := '0';

-- Output
signal recieve : out std_logic_vector(3 downto 0);

-- Inout
signal data : inout std_logic_vector(3 downto 0);

begin 
  uut: biport port map(send=>send, occurrence=>occurrence, recieve=>recieve, data=>data);
    
    stim_proc: process
    begin
      wait for 100 ns;
      
      assert false report "Reached end of test";
      wait;
    end process;
end behavioral;
    
