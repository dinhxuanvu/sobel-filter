-------------------------------------------------------------------------------
-- File: memory.vhd
-- Entity: memory
-- Architecture: Behavioral
-- Author: Drew Carlstedt
-- Created: 11/20/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a shift register
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity memory is
  port
  (
    i_reset      :    in  std_logic;
    i_clock      :    in  std_logic;
    i_pixel      :    in  std_logic_vector(7 downto 0);
    o_pt         :    out std_logic_vector(71 downto 0)
  );
end memory;

-------------------------------------------------------------------------------

architecture behavioral of memory is
  
begin
  
end behavioral;


