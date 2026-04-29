-- Template for counter implementation
-- Copyright 2017-2023 Aston University

library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- need this for std_logic types
use IEEE.NUMERIC_STD.ALL; -- need this for unsigned and signed types type

entity counter is
  generic (
    start: integer:=0; -- where count starts from
    finish: integer:=9; -- where count ends (inclusive)
    nbits: integer:=4 -- number of bits for counter
    );
  port (
    clk: in  std_logic;  -- system clock
    ce: in std_logic;    -- count or clock enable
    reset: in std_logic; -- asynchronous reset
    count: out unsigned(nbits-1 downto 0); -- output count
    tc: out std_logic:='0' -- set to '1' at terminal count for cascading
    );
end counter;

architecture rtl of counter is
  -- it helps clarity to declare constants for commonly used values
  constant ustart: unsigned:=to_unsigned(start,nbits);
  constant ufinish: unsigned:=to_unsigned(finish,nbits);
  -- internal counter register declared as a signal.
  signal count_i: unsigned(nbits-1 downto 0):=ustart;
begin
  count<=count_i;
  tc <= '1' when count_i = ufinish else '0'; 
  -- What this means is, terminal count (tc) pulses every time the counter finishes a cycle.

  SYNC_PROC: process(clk,reset)
  begin
   if reset = '1' then
     count_i <= ustart; --asynchronous reset. After a reset, start the counter all over again.
     elsif rising_edge (clk) then
        if ce = '1' then
          if count_i=ufinish then 
--^ This means when count_i reaches the end, restart it from the beginning ustart
            count_i<=ustart;
            elsif start<finish then 
--^ This is assigning whether or not we are counting up or down depending on what value we set 'start'or 'finish'
              count_i<=count_i+1; 
              else count_i<=count_i-1;
            end if;
        end if;
   end if;
  end process;
end rtl;
