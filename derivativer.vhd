-------------------------------------------------------------------------------
-- File: derivativer.vhd
-- Entity: derivativer
-- Architecture: Behavioral
-- Author: Drew Carlstedt
-- Created: 11/20/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a 4(3x3)
-- derivative module
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity derivativer is
  port
  (
    i_clock      :    in  std_logic;
    i_n_s        :    in  std_logic_vector(8 downto 0);
    i_e_w        :    in  std_logic_vector(8 downto 0);
    i_ne_sw      :    in  std_logic_vector(8 downto 0);
    i_nw_se      :    in  std_logic_vector(8 downto 0);
    o_d_n_e      :    out std_logic_vector(15 downto 0);
    o_d_ne_nw    :    out std_logic_vector(15 downto 0)
  );
end derivativer;

-------------------------------------------------------------------------------

architecture behavioral of derivativer is
  
begin
  
end behavioral;


