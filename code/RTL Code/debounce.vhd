library IEEE;
use IEEE.std_logic_1164.all;

entity debounce is
  port (
    clk: in std_logic;    -- system clock
    clk_en: in std_logic; -- low frequency sampling clock enable (e.g. 1kHz)
    button: in std_logic;    -- input from button
    debounced: out std_logic:= '0'; -- the debounced button level output 
    down_event: out std_logic:= '0' -- enable event signal when button pressed
    );
end debounce;

architecture behavioural of debounce is
  signal delay1  : std_logic:='0'; -- delayed version of button input
  signal delay2  : std_logic:='0'; -- delayed version of delay1
  signal delay3  : std_logic:='0'; -- high when input stable
  signal debounced_prev: std_logic:='0'; -- previous value of debounced
begin 
  process(clk)
begin
  if rising_edge(clk) then
    if clk_en = '1' then
      delay1 <= button; -- This is a sample register
      delay2 <= delay1;
    end if;
    
-- Ensuring unanimity of the last three samples before changing output (These are Shift Registers)
    if (delay1 = delay2) and (delay2 = button) then 
      delay3 <= button;
    end if;

    debounced_prev <= delay3;
  end if;
end process;

--Outputs Assignments
debounced <= delay3;
down_event <= '1' when (delay3 = '1' and debounced_prev = '0') else '0';
end behavioural;

-- The logic of the down_event is the way it is because, when you start process, debounced_prev will always be zero.
-- Debounced_prev becomes '1' in the next clock edge after delay3 = '1'. When Debounced_prev becomes 1, 
-- delay3 = '0'. This is also known as edge detection.