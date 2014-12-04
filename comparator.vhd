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

  signal s_d_n, s_d_e, s_d_ne, s_d_nw : std_logic_vector(10 downto 0);

begin
  
  compare: process(i_clock)
  variable d_n, d_ne                : std_logic_vector(10 downto 0);
  variable d_max                    : std_logic_vector(21 downto 0);
  variable dir_n, dir_ne, dir_max   : std_logic_vector(2 downto 0);
  
  begin
    s_d_n   <= i_d_n_e(21 downto 11);
    s_d_e   <= i_d_n_e(10 downto 0);
    s_d_ne  <= i_d_ne_nw(21 downto 11);
    s_d_nw  <= i_d_ne_nw(10 downto 0);
    
    -- compare N and E
    if ( s_d_n < s_d_e ) then
      d_n      := s_d_e;
      dir_n    := "000";
    else
      d_n      := s_d_n;
      dir_n    := "010";
    end if;
    -- compare NE and NW
    if ( s_d_ne < s_d_nw ) then
      d_ne      := s_d_nw;
      dir_ne    := "100";
    else
      d_ne      := s_d_ne;
      dir_ne    := "110";
    end if;
    -- compare N/E and NE/NW
    if (d_n < d_ne ) then
      d_max   := i_d_ne_nw;
      dir_max := dir_ne;
    else
      d_max   := i_d_n_e;
      dir_max := dir_n;
    end if;
    
    -- if negative, opposite direction
    if ( d_max < 0 ) then
      case dir_max is
        when "000"  => o_dir <= "001";
        when "010"  => o_dir <= "011";
        when "100"  => o_dir <= "101";
        when others => o_dir <= "111";
      end case;
    else
      o_dir <= dir_max;
    end if;
    
    o_d <= d_max;
    
  end process compare;
  
end behavioral;