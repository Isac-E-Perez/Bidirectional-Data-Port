# Bidirectional Data Port

### About:

For this project, I created a bidirectional data port with the use of VHDL code. The circuit contains an input bundle of four signals and an output bundle of four signals. The bidirectional data port has an output of *recieve* which was influence by the *occurrence*. Bidirectional is a communications mode that is capable of transmitting data in both directions (send and receive), but not at the same time.

**Digital Design Diagram**

<img width="321" alt="Screen Shot 2021-10-21 at 3 09 35 PM" src="https://user-images.githubusercontent.com/89553126/138349722-7cf2669f-fc19-46e4-82a0-4dc59aed5eac.png">
 
### Note:

To avoid data contention, I made sure that the data equalled **Z** when data is to be an output again. In database management systems, block contention (or data contention) refers to multiple processes or instances competing for access to the same index or data block at the same time.

### Results:

In VHDL, *send* and *occurrence* are the inputs (**IN**), *recieve* is an output (**OUT**) and *data* is an input and output (**INOUT**) of my project.

**I/O's are specified here (the circuit is specified using a Hardware Desciption Language)**

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity biport is
  port (
        send : in std_logic_vector(3 downto 0);
        occurrence : in std_logic;
        recieve : out std_logic_vector(3 downto 0); 
        data : inout std_logic_vector(3 downto 0) 
        );
end biport;
```

**Internal description of the bidirectional data port is specified here**

```vhdl
architecture behavioral of biport is
  
begin
    data <= send when occurrence = '0' else (others => 'Z');
    recieve <= data when occurrence = '1' else (others => 'Z');
end behavioral;  
```

Afterwards, I worked on the behavioral (functional) simulation. Here, I will only verify the operations of the circuit. Stimuli is provided to the circuit, so I can verify the outputs behave as I expect. The VHDL file called 'biport_tb' is where I specified the stimuli to the circuit.

```vhdl
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
signal recieve : std_logic_vector(3 downto 0);

-- Inout
signal data : std_logic_vector(3 downto 0);

begin 
  uut: biport port map(send=>send, occurrence=>occurrence, recieve=>recieve, data=>data);
    
    stim_proc: process
    begin
      
      data <= "ZZZZ"; wait for 100 ns;
      occurrence <= '0'; send <= x"A"; data <= "ZZZZ"; wait for 20 ns;
      occurrence <= '1'; data <= x"E"; wait for 20 ns;
      occurrence <= '0'; send <= x"9"; data <= "ZZZZ"; wait for 20 ns;
      occurrence <= '1'; send <= x"3"; wait for 20 ns;
                         data <= x"C"; 
      
      assert false report "Reached end of test";
      wait;
    end process;
end behavioral;
```

The entity block has no input or output singals going into or out of the 'testbench', which makes sense since 'testbench' is a complete unit. The 'testbench' will go ahead and send the signals to the circuit in which it will read back those signals. Afterwards, I could check out whether these signals are correct. Therefore, I don't need anything going into or out of the testbench. Additionally, the process statement is a concurrent statement which is constituted of sequential statements exclusively.

Finally, I verified the units outputted by using a waveform viewer.

**Nothing is being *send* or *recieved***

![0](https://user-images.githubusercontent.com/89553126/138342475-d8fb0988-fc97-45d8-a73c-cdf2384f0a88.png)

**A signal is being *send*, *data* is produced, yet *occurrence* is not **1** so the *data* is not *recieve* by the user**

![1](https://user-images.githubusercontent.com/89553126/138342485-d133533a-30dc-47b9-bd9e-a21c44ba5409.png)

**A signal is being *send*, *data* is produced, and the *occurrence* is **1** so the *data* is *recieve* by the user**

![2](https://user-images.githubusercontent.com/89553126/138342494-dbf1244b-76e7-4636-adad-2bb56c3a1319.png)

**A signal is being *send*, *data* is produced, yet *occurrence* is not **1** so the *data* is not *recieve* by the user**

![3](https://user-images.githubusercontent.com/89553126/138342500-02caf291-5bae-4e57-970a-d0c948bf09b7.png)

***A signal is being *send*, *data* is produced, and the *occurrence* is **1** so the *data* is *recieve* by the user**

In this case, *ZZZZ* *recieve* as to avoid data contention. Think of has a reset for the *recieve* *data* so more *data* can be *recieve* later.

![4](https://user-images.githubusercontent.com/89553126/138342508-65b80292-0d76-4564-be36-5ebe7201577a.png)

**A signal is being *send*, *data* is produced, and the *occurrence* is **1** so the *data* is *recieve* by the user**

![5](https://user-images.githubusercontent.com/89553126/138342517-5a9bdec3-e9ba-4a35-b025-53515b7e5717.png)

Looking back to the digital design diagram, waveform, and the definition of a bidirectional data port, the code produce what should be expected, therefore, I know my bidirectional data port code is operating correctly.
