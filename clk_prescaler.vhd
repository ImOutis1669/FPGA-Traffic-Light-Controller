-- Template to implement a clock prescaler
-- The template is Copyright 2017-2023 Aston University

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.math_real.all; -- needed for mathematical calculations

entity clk_prescaler is
  generic (
    n: integer                   --  divide clk by n to generate clk_div
  );
  port (
    clk: in std_logic;           -- input (system) clock
    clk_div: out std_logic:='0'  -- clock enable signal at clk/n frequency
    );
end clk_prescaler;

architecture behavioural of clk_prescaler is
  constant nbits: integer:=integer(ceil(log2(real(n)))); 
  -- (log2(real(n)) → calculates the base-2 logarithm)
  -- ciel() rounds n up to the neareast integer
  -- real(n) → converts n (an integer generic, presumably) to a real.
  -- nbits is the minimum number of bits required to represent the number n in binary.
  signal count: unsigned(nbits-1 downto 0) :=(others=>'0');
  
begin
  cp: process(clk)
  begin
   if rising_edge(clk) then
     if count=n-1 then
       clk_div<='1';  -- set clk_div high for one clk cycle
       count<=(others=>'0'); -- reset counter, this is the same as count <= '0' but bit-wise
     else
       clk_div<='0';
       count<=count+1;  -- increment counter
     end if;
   end if;
  end process;
end behavioural;
