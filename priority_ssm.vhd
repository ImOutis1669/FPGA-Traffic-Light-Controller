library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

entity priority_ssm is
port (
    clk                 : in std_logic;
    time                : in unsigned(5 downto 0);
    sensor              : in std_logic;
    start_timer         : out std_logic:= '1';
    -- lights start at RAR out
    Rmin, Rmaj, Amaj    : out std_logic:= '1';
    Amin, Gmin, Gmaj    : out std_logic:= '0'
);
end priority_ssm;

architecture rtl of priority_ssm is
  -- list states names for state type here e.g. S0,S1 etc
  type state_type is (ST0,ST1,ST2,ST3,ST4,ST5);
  signal state,next_state: state_type; -- current and next state
  signal time_pulse : std_logic;
  signal switch_sensor: std_logic;
  
begin

  -- Clocked Process for synchronous (clocked) operation
  SYNC_PROC: process (clk) 
  begin
    if rising_edge(clk) then-- here we have a synchronous reset (preferred)
        start_timer <= time_pulse;
        state <= next_state;
    end if;
  end process;

  -- Combinational Process for the output decoding.
  -- for a Moore model it will be sensitive to state only
  -- for a Mealy model it will also be sensitive to immediate inputs 
  OUTPUT_DECODE: process (state)
  begin
    -- assign default outputs here to ensure all outputs are set for each case
    
    -- case statement for each state which sets outputs as required
    -- Mealy outputs will also test inputs

    case (state) is
      when ST0 =>
        Rmin <= '1';
        Rmaj <= '1';
        Amaj <= '1';
        Amin <= '0';
        Gmin <= '0';
        Gmaj <= '0';
      when ST1 =>
        Rmin <= '1';
        Rmaj <= '0';
        Amaj <= '0';
        Amin <= '0';
        Gmin <= '0';
        Gmaj <= '1';
      when ST2 =>
        Rmin <= '1';
        Rmaj <= '0';
        Amaj <= '1';
        Amin <= '0';
        Gmin <= '0';
        Gmaj <= '0';
      when ST3 =>
        Rmin <= '1';
        Rmaj <= '1';
        Amaj <= '0';
        Amin <= '1';
        Gmin <= '0';
        Gmaj <= '0';
      when ST4 =>
        Rmin <= '0';
        Rmaj <= '1';
        Amaj <= '0';
        Amin <= '0';
        Gmin <= '1';
        Gmaj <= '0';
      when ST5 =>
        Rmin <= '0';
        Rmaj <= '1';
        Amaj <= '0';
        Amin <= '1';
        Gmin <= '0';
        Gmaj <= '0';
      when others => -- when others catchall safe output
    end case;
  end process;

  NEXT_STATE_DECODE: process (state,time)
  begin
    -- assign a default next state if appropriate
    time_pulse <= '0';
    next_state <= state;
    
    -- case statement checking current state
    -- and checking inputs to determine next state.
    case (state) is
      when ST0 =>
        if time  = 2 then
        next_state <= ST1;
        time_pulse <= '1';
        end if;

      when ST1 =>
        if (time >= 15) and (sensor = '1') then
        next_state <= ST2;
        time_pulse <= '1';   
        end if;

      when ST2 =>
        if time = 4 then
        next_state <= ST3;
        time_pulse <= '1';
        end if;

      when ST3 =>
        if time = 2 then
        next_state <= ST4;
        time_pulse <= '1';
        end if;

      when ST4 => 
        if time >= 10 and sensor = '0' then
        next_state <= ST5;
        time_pulse <= '1';
        end if;
        if time = 30 then
        next_state <= ST5;
        time_pulse <= '1';
        end if;

      when ST5 =>
        if time = 4 then 
        next_state <= ST0;
        time_pulse <= '1';
        end if;
      
      when others =>  -- have when others catchall to go to a safe state
        next_state <= ST0;
    end case;
  end process;
  
end rtl;