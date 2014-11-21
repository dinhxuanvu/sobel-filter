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

entity state is
  port
  (
    i_valid      :    in  std_logic;
    i_clock      :    in  std_logic;
    i_reset      :    in  std_logic;
    o_valid      :    out std_logic;
    o_mode       :    out std_logic_vector(1 downto 0)
  );
end state;

-------------------------------------------------------------------------------

architecture behavioral of state is
  
begin
  
  process (i_clock)
  
  begin
  if (rising_edge(i_clock) then
    if (i_valid) then
      -- FIXME need to calculate cycles it takes to get a good output
      -- also this "valid" needs to stay valid for entire time in busy mode
      -- but the o_valid for sobel is only valid for one clock cycle...
      -- ... maybe output a reset bit for the other modules as well?
      o_valid <= '1';
      o_mode <= "11";
    else
      o_valid <= '0';
      o_mode <= "10";
    end if;
    if (i_reset) then
      o_valid <= '0';
      o_mode <= "01"
    end if;
  end if;
  end process;
  
end behavioral;

