
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
  port (
    x    : in  std_logic; 
    y    : in  std_logic;
    cin  : in  std_logic;
    s    : out std_logic;
    cout : out std_logic
    );
end full_adder;

architecture behavioral of full_adder is
begin
  s    <=     x xor y xor cin;       -- This is the boolean algebraic experssion for S and Cout
  cout <=     (x and y) or (x and cin) or (y and cin);     
  end architecture;               
