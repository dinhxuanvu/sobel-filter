-------------------------------------------------------------------------------
-- File: memory.vhd
-- Entity: memory
-- Architecture: Behavioral
-- Author: Drew Carlstedt, Vu Dinh
-- Created: 11/20/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a shift register
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity memory is
  port
  (
    i_enable     :    in  std_logic;
    i_clock      :    in  std_logic;
    i_pixel0     :    in  std_logic_vector(7 downto 0);
    i_pixel1     :    in  std_logic_vector(7 downto 0);
    i_pixel2     :    in  std_logic_vector(7 downto 0);
    i_pixel3     :    in  std_logic_vector(7 downto 0);
    i_pixel4     :    in  std_logic_vector(7 downto 0);
    i_pixel5     :    in  std_logic_vector(7 downto 0);
    i_pixel6     :    in  std_logic_vector(7 downto 0);
    i_pixel7     :    in  std_logic_vector(7 downto 0);
    i_pixel8     :    in  std_logic_vector(7 downto 0);
    o_ct         :    out std_logic_vector(71 downto 0)
  );
end memory;

-------------------------------------------------------------------------------
-- | 71 downto 64 | 63 downto 56 | 55 downto 48 |
-- | 47 downto 40 | 39 downto 32 | 31 downto 24 |
-- | 23 downto 16 | 15 downto 8  |  7 downto 0  |
architecture behavioral of memory is
  
begin
  mem : process (i_clock)
  begin
    if (rising_edge(i_clock)) then
      o_ct(7 downto 0) <= i_pixel0;
      o_ct(15 downto 8) <= i_pixel1;
      o_ct(23 downto 16) <= i_pixel2;
      o_ct(31 downto 24) <= i_pixel3;
      o_ct(39 downto 32) <= i_pixel4;
      o_ct(47 downto 40) <= i_pixel5;
      o_ct(55 downto 48) <= i_pixel6;
      o_ct(63 downto 56) <= i_pixel7;
      o_ct(71 downto 64) <= i_pixel8;
    end if;
  end process;
end behavioral;