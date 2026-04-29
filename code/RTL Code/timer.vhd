library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 


entity timer is 
port(
    clk             : in STD_LOGIC; -- system clk (100MHz)
    clk_en          : in STD_LOGIC; -- timing clk 
    start_timer     : in STD_LOGIC; -- reset time to 0 synchronously 
    time            : out unsigned(5 downto 0) -- the output count
);
end timer;
architecture behavioural of timer is
signal time_i: unsigned (5 downto 0);

begin 
cp: process(clk)
-- Similar to clk prescaler code
    begin
        if rising_edge(clk) then
            if start_timer  = '1' then 
            time_i <= (others =>'0'); -- This resets the timer, this is the same as time_i <= '0' but bit-wise
                else if clk_en = '1' then 
                time_i <= time_i + 1; 
                end if;
            end if;
        end if;
       
-- Output Assignment
        time <= time_i;    
    end process; 
end architecture;