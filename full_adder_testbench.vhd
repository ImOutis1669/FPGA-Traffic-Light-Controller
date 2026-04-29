-- declarations for standard logic as needed
library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;
-- use ieee.math_real.all;

-- testbench entity has no inputs and outputs
entity full_adder_testbench is
end full_adder_testbench;

architecture testbench of full_adder_testbench is
  component full_adder is
    port (  x    : in  std_logic;
    y    : in  std_logic; -- These are the same inputs and outputs from the entity 'full adder'
    cin  : in  std_logic;
    s    : out std_logic;
    cout : out std_logic
    );
      
  end component;

signal input : std_logic_vector(2 downto 0);
signal output :std_logic_vector(1 downto 0);-- other declarations needed for test go here e.g. signal declarations

begin
  -- entity instantiation with port maps goes here
  top: full_adder port map (
    x    => input(1),
    y    => input(0),
    cin  => input(2),
    s    => output(1),
    cout => output(0)
  ); 
   -- map uut ports to local signals here
    

  stim_proc : process
  begin
    input <= "000" ; wait for 10 ns ; assert output = "00" report "0+0+0 failed";
    input <= "001" ; wait for 10 ns ; assert output = "10" report "0+0+1 failed";
    input <= "010" ; wait for 10 ns ; assert output = "10" report "0+1+0 failed";
    input <= "011" ; wait for 10 ns ; assert output = "01" report "0+1+1 failed";
    input <= "100" ; wait for 10 ns ; assert output = "10" report "1+0+0 failed";
    input <= "101" ; wait for 10 ns ; assert output = "01" report "1+0+1 failed";
    input <= "110" ; wait for 10 ns ; assert output = "01" report "1+1+0 failed";
    input <= "111" ; wait for 10 ns ; assert output = "11" report "1+1+1 failed";
    -- test bench behaviour goes here

    -- stop process when finished test
    wait;
  end process;

end testbench;
