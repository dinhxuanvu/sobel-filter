-------------------------------------------------------------------------------
-- File: algorithm.vhd
-- Entity: algorithm
-- Architecture: Behavioral
-- Author: Drew Carlstedt
-- Created: 11/20/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a sobel
-- algorithm module
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity algorithm is
  port
  (
    i_valid      :    in  std_logic;
    i_clock      :    in  std_logic;
    i_d          :    in  std_logic_vector(15 downto 0);
    i_dir        :    out std_logic_vector(2 downto 0);
    o_edge       :    out std_logic;
    o_dir        :    out std_logic_vector(2 downto 0)
  );
end algorithm;

-------------------------------------------------------------------------------

architecture behavioral of algorithm is
  
begin
  
end behavioral;

