-------------------------------------------------------------------------------
-- File: state.vhd
-- Entity: state
-- Architecture: Behavioral
-- Author: Drew Carlstedt
-- Created: 11/20/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a state machine
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity state is
  port
  (
    i_valid      :    in  std_logic;
    i_reset      :    in  std_logic;
    o_valid      :    out std_logic;
    o_mode       :    out std_logic_vector(1 downto 0)
  );
end state;

-------------------------------------------------------------------------------

architecture behavioral of state is
  
begin
  
end behavioral;

