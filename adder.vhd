-------------------------------------------------------------------------------
-- File: adder.vhd
-- Entity: adder
-- Architecture: Behavioral
-- Author: Drew Carlstedt, Vu Dinh
-- Created: 11/20/2014
-- VHDL'93
-- Description:
-- The following is the entity and architecture of an 8-bit adder
-- (stub for optimized tree adder)
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity adder is
  port
  (
    i_reset      :    in  std_logic;
    i_clock      :    in  std_logic;
    i_c          :    in  std_logic;
    i_x          :    in  std_logic_vector(8 downto 0);
    i_y          :    in  std_logic_vector(8 downto 0);
    o_z          :    out std_logic_vector(8 downto 0);
    o_c          :    out std_logic
  );
end adder;
-------------------------------------------------------------------------------

architecture behavioral of adder is
  
begin
  add: process
    variable temp : std_logic_vector(8 downto 0);
  begin
    temp := std_logic_vector(unsigned("0" & i_x) + unsigned("0" & i_y) + unsigned ("0000000" & i_c));
    o_z <= temp(7 downto 0);
    o_c <= temp(8);
  end process add;
  
end behavioral;