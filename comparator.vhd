-------------------------------------------------------------------------------
-- File: comparator.vhd
-- Entity: comparator
-- Architecture: Behavioral
-- Author: Drew Carlstedt, Vu Dinh
-- Created: 11/20/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a 11-bit
-- comparator
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_signed.all;

entity comparator is
  port
  (
    i_enable     :    in  std_logic;
    i_clock      :    in  std_logic;
    i_d_n_e      :    in  std_logic_vector(21 downto 0);
    i_d_ne_nw    :    in  std_logic_vector(21 downto 0);
    o_d          :    out std_logic_vector(21 downto 0);
    o_dir        :    out std_logic_vector(2 downto 0)
  );
end comparator;

-------------------------------------------------------------------------------

architecture behavioral of comparator is

  

begin
  
  compare: process(i_clock)
  variable v_d_n, v_d_e, v_d_ne, v_d_nw : std_logic_vector(10 downto 0);
  variable d_n, d_ne                : std_logic_vector(10 downto 0);
  variable d_max                    : std_logic_vector(10 downto 0);
  variable dir_n, dir_ne, dir_max   : std_logic_vector(2 downto 0);
  
  begin
 
  if (rising_edge(i_clock)) then
    
    v_d_n   := i_d_n_e(21 downto 11);
    v_d_e   := i_d_n_e(10 downto 0);
    v_d_ne  := i_d_ne_nw(21 downto 11);
    v_d_nw  := i_d_ne_nw(10 downto 0);
    
    -- compare N and E
    if (abs(v_d_n) < abs(v_d_e)) then
      d_n      := v_d_e;
      dir_n    := "000";
    else
      d_n      := v_d_n;
      dir_n    := "010";
    end if;
    -- compare NE and NW
    if (abs(v_d_ne) < abs(v_d_nw)) then
      d_ne      := v_d_nw;
      dir_ne    := "100";
    else
      d_ne      := v_d_ne;
      dir_ne    := "110";
    end if;
    -- compare N/E and NE/NW
    if (abs(d_n) < abs(d_ne)) then
      d_max   := d_ne;
      dir_max := dir_ne;
    else
      d_max   := d_n;
      dir_max := dir_n;
    end if;
    
    -- if negative, opposite direction
    if (d_max < 0) then
      case dir_max is
        when "000"  => 
              o_dir <= "001";
              o_d   <= (d_max & v_d_n); 
        when "010"  => 
              o_dir <= "011";
              o_d   <= (d_max & v_d_e); 
        when "100"  => 
              o_dir <= "101";
              o_d   <= (d_max & v_d_ne);
        when others => 
              o_dir <= "111";
              o_d   <= (d_max & v_d_nw);
      end case;
    else
      o_dir <= dir_max;
    end if;
    
  end if;  
  
  end process compare;
  
end behavioral;