-------------------------------------------------------------------------------
-- File: algorithm.vhd
-- Entity: algorithm
-- Architecture: Behavioral
-- Author: Drew Carlstedt, Vu Dinh
-- Created: 11/20/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a sobel
-- algorithm module
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_signed.all;

entity algorithm is
  port
  (
    i_enable     :    in  std_logic;
    i_clock      :    in  std_logic;
    i_d          :    in  std_logic_vector(21 downto 0);
    i_dir        :    in std_logic_vector(2 downto 0);
    o_edge       :    out std_logic;
    o_dir        :    out std_logic_vector(2 downto 0)
  );
end algorithm;

-------------------------------------------------------------------------------

architecture behavioral of algorithm is
begin
  algo : process(i_clock)
  variable temp1 : std_logic_vector(10 downto 0);
  variable temp2 : std_logic_vector(10 downto 0);
  variable total : std_logic_vector(10 downto 0);
  begin
    if (rising_edge(i_clock)) then
      temp1 := abs(i_d(21 downto 11));
      temp2 := abs(i_d(10 downto 0));
      total := (temp1 + ("000" & temp2(10 downto 3)));
      if (total >= 80) then
        o_edge <= '1';
        o_dir <= i_dir;
      else
        o_edge <= '0';
        o_dir <= "000";
      end if;
    end if;
  end process;
end behavioral;
