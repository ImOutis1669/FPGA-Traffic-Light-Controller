library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

entity priority_lights is
port (
    clk                                 : std_logic;
    time                                : in unsigned(5 downto 0);
    switch_sensor                          : in std_logic;
    Rmin, Amin, Gmin, Rmaj, Amaj, Gmaj  :out std_logic
);
end priority_lights;

architecture structural of priority_lights is
-- Component Declaration

    component clk_prescaler is 
        generic (
        n: integer                   --  divide clk by n to generate clk_div
    );
    port (
        clk: in std_logic;           -- input (system) clock
        clk_div: out std_logic:='0'  -- clock enable signal at clk/n frequency
        );
end component clk_prescaler;

    component timer is
        port(
        clk             : in STD_LOGIC; -- system clk (100MHz)
        clk_en          : in STD_LOGIC; -- timing clk 
        start_timer     : in STD_LOGIC; -- reset time to 0 synchronously 
        time            : out unsigned(5 downto 0) -- the output count
    );
end component timer;
    
    component priority_ssm is
        port (
        clk                 : in std_logic;
        time                : in unsigned(5 downto 0);
        sensor              : in std_logic;     
        start_timer         : out std_logic:= '1';
        -- lights start at RAR out
        Rmin, Rmaj, Amaj    : out std_logic:= '1';
        Amin, Gmin, Gmaj    : out std_logic:= '0'
            );
end component priority_ssm;

-- Declaring signals
signal clk_1hz          : std_logic;
signal timer_start      : std_logic;
signal internal_time    : unsigned(5 downto 0);

begin
-- Instantiation of components
Prescaler_1Hz: clk_prescaler
generic map(
    n =>100000000
    )
port map(
    clk => clk,
    clk_div => clk_1hz
);
prioritytraffic_timer: timer
    port map(
        clk => clk,
        clk_en => clk_1hz,      
        start_timer => timer_start,
        time => internal_time       
);

priorityssm: priority_ssm
    port map(
        clk => clk,
        time => internal_time,
        sensor => switch_sensor,
        start_timer => timer_start,
-- Minor Traffic Lights
        Rmin => Rmin,
        Amin => Amin,
        Gmin => Gmin,
-- Major Traffic Lights
        Rmaj => Rmaj,
        Amaj => Amaj,
        Gmaj => Gmaj
);
end structural;