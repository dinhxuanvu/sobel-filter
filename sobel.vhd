-------------------------------------------------------------------------------
-- File: sobel.vhd
-- Entity: sobel
-- Architecture: structural
-- Author: Drew Carlstedt
-- Created: 11/20/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a sobel
-- edge detector
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity sobel is
  port
  (
    i_clock      :    in  std_logic;
    i_valid      :    in  std_logic;
    i_pixel      :    in  std_logic_vector(7 downto 0);
    i_reset      :    in  std_logic;
    o_edge       :    out std_logic;
    o_dir        :    out std_logic_vector(2 downto 0);
    o_valid      :    out std_logic;
    o_mode       :    out std_logic_vector(1 downto 0)
  );
end sobel;

-------------------------------------------------------------------------------

architecture structural of sobel is
  
begin
  
end structural;
