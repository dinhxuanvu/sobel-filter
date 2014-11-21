-------------------------------------------------------------------------------
-- File: comparator.vhd
-- Entity: comparator
-- Architecture: Behavioral
-- Author: Drew Carlstedt
-- Created: 11/20/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a 8-bit
-- comparator
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity comparator is
  port
  (
    i_valid      :    in  std_logic;
    i_d_n_e      :    in  std_logic_vector(15 downto 0);
    i_d_ne_nw    :    in  std_logic_vector(15 downto 0);
    o_d          :    out std_logic_vector(15 downto 0);
    o_dir        :    out std_logic_vector(2 downto 0)
  );
end comparator;

-------------------------------------------------------------------------------

architecture behavioral of comparator is
  
begin
  
end behavioral;