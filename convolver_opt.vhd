-------------------------------------------------------------------------------
-- File: convolver.vhd
-- Entity: convolver
-- Architecture: Behavioral
-- Author: Drew Carlstedt
-- Created: 11/20/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a 3x3
-- convolution module
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity convolver is
  port
  (
    i_valid      :    in  std_logic;
    i_clock      :    in  std_logic;
    i_pt         :    in  std_logic_vector(8 downto 0);
    o_ne_sw      :    out std_logic_vector(8 downto 0);
    o_n_s        :    out std_logic_vector(8 downto 0);
    o_e_w        :    out std_logic_vector(8 downto 0);
    o_nw_se      :    out std_logic_vector(8 downto 0)
  );
end convolver;

-------------------------------------------------------------------------------

architecture behavioral of convolver is
  
begin
  
end behavioral;