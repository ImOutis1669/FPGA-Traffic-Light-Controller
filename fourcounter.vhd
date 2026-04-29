library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- need this for unsigned and signed types type
use ieee.math_real.all; -- needed for mathematical calculations

entity fourcounter is
  port (
    RESET : in std_logic; -- asynchronous reset
    clk   : in std_logic;-- system clock
    btn   : in std_logic; -- button to enable counting
    LED0  : out std_logic;
    LED1  : out std_logic;
    LED2  : out std_logic;
    LED3  : out std_logic;
    LED4  : out std_logic;
    LED5  : out std_logic;
    LED6  : out std_logic;
    LED7  : out std_logic;
    LED8  : out std_logic;
    LED9  : out std_logic;
    LED10 : out std_logic;
    LED11 : out std_logic;
    LED12 : out std_logic;
    LED13 : out std_logic;
    LED14 : out std_logic;
    LED15 : out std_logic
  );
end fourcounter;

architecture structural of fourcounter is
 component clk_prescaler is 
    generic (
      n: integer                   --  divide clk by n to generate clk_div
  );
  port (
    clk: in std_logic;           -- input (system) clock
    clk_div: out std_logic:='0'  -- clock enable signal at clk/n frequency
    );
end component clk_prescaler;

component debounce is
  port (
    clk: in std_logic;    -- system clock
    clk_en: in std_logic; -- low frequency sampling clock enable (e.g. 1kHz)
    button: in std_logic;    -- input from button
    debounced: out std_logic:= '0'; -- the debounced button level output 
    down_event: out std_logic:= '0' -- enable event signal when button pressed
    );
end component debounce;

component counter is
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
end component counter;

--Declaration of arrays for counter, ce and tc
type count_array is array(0 to 3) of unsigned(3 downto 0);
type ce_array is array(0 to 3) of std_logic;
type tc_array is array(0 to 3) of std_logic;

-- Internal signal declarations
signal cnt: count_array; 
signal ce: ce_array;
signal tc: tc_array;
signal clk_en_1kHz: std_logic;
signal clk_en_2Hz: std_logic;
signal debounced_btn: std_logic; 
signal debounced_reset: std_logic;
signal btn_downevent: std_logic;
signal reset_downevent: std_logic;

begin
-- Instantiation of Components
prescaler_1kHz: clk_prescaler 
  generic map(
    n => 100000
  )
  port map(
    clk => clk,
    clk_div => clk_en_1kHz
  );

prescaler_2Hz: clk_prescaler
  generic map(
    n => 50000000
  )
  port map(
    clk => clk,
    clk_div => clk_en_2Hz
  );

reset_btn: debounce
  port map(
    clk => clk,
    clk_en => clk_en_1kHz,
    button => RESET,
    debounced => debounced_reset,
    down_event => reset_downevent
  );
button: debounce
  port map(
    clk => clk,
    clk_en => clk_en_1kHz,
    button => btn,
    debounced => debounced_btn,
    down_event => btn_downevent
  );
-- Connections as per Figure 2.7 
ce(0) <= debounced_btn AND clk_en_2Hz;
ce(1) <= ce(0) AND tc(0);
ce(2) <= ce(1) AND tc(1);
ce(3) <= ce(2) AND tc(2);

counter_gen : for i in 0 to 3 generate

  counter_inst : counter
      port map(
          clk   => clk,
          ce    => ce(i),
          reset => debounced_reset,
          count => cnt(i),
          tc    => tc(i)
        );
end generate counter_gen;
-- ^ what that line of code does basically represents diffent instances of the counter where certain ports change
-- with 'i'. This is similar to writing 
-- counter_inst_0 : counter
--port map (
--clk   => clk,
--ce    => ce(0),
--reset => debounced_reset,
--count => cnt(0),
--tc    => tc(0)
--);

--counter_inst_1 : counter
--port map (
--clk   => clk,
--ce    => ce(1),
--reset => debounced_reset,
--count => cnt(1),
--tc    => tc(1)
--);

-- LED Assignments Per Counter Outputs
LED0  <= cnt(0)(0);
LED1  <= cnt(0)(1);
LED2  <= cnt(0)(2);
LED3  <= cnt(0)(3);

LED4  <= cnt(1)(0);
LED5  <= cnt(1)(1);
LED6  <= cnt(1)(2);
LED7  <= cnt(1)(3);

LED8  <= cnt(2)(0);
LED9  <= cnt(2)(1);
LED10 <= cnt(2)(2);
LED11 <= cnt(2)(3);

LED12 <= cnt(3)(0);
LED13 <= cnt(3)(1);
LED14 <= cnt(3)(2);
LED15 <= cnt(3)(3);

end structural;
