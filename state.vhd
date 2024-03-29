-------------------------------------------------------------------------------
-- File: state.vhd
-- Entity: state
-- Architecture: Behavioral
-- Author: Drew Carlstedt
-- Created: 11/20/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a state machine
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity state is
  port
  (
    i_reset      :    in  std_logic;
    i_clock      :    in  std_logic;
    i_valid      :    in  std_logic;
    o_valid      :    out std_logic;
    o_mode       :    out std_logic_vector(1 downto 0);
    o_enable     :    out std_logic
  );
end state;

-------------------------------------------------------------------------------

architecture behavioral of state is
  
begin
  
  state: process (i_clock)
  variable count : std_logic_vector(3 downto 0);
  begin 
    if (rising_edge(i_clock)) then
      if (i_reset='1') then
        o_valid <= '0';
        o_mode <= "01";
        count := "0000";
      else
        if (i_valid='1') then
          o_mode <= "11";
          -- count to 9 pixels
          if (unsigned(count) >= 9) then
            count := "0001";-- all the logic is contained within one clock cycle
            o_valid <= '1';
          else
            count := std_logic_vector(unsigned(count) + 1);
          end if;
        else
          o_valid <= '0';
          o_mode <= "10";
        end if;
      end if;
    end if;
  end process state;
  
end behavioral;

