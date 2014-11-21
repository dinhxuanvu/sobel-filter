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
    i_reset      :    in  std_logic;
    i_clock      :    in  std_logic;
    i_ct         :    in  std_logic_vector(71 downto 0));
    o_d_n_e      :    out std_logic_vector(15 downto 0);
    o_d_ne_nw    :    out std_logic_vector(15 downto 0)
  );
end derivativer;

-------------------------------------------------------------------------------
-- | 71 downto 64 | 63 downto 56 | 55 downto 48 |
-- | 47 downto 40 | 39 downto 32 | 31 downto 24 |
-- | 23 downto 16 | 15 downto 8  |  7 downto 0  |
architecture behavioral of derivativer is
  -- FIXME make it structural adding
begin
  
derivative : process (i_clock)

begin
  
  if rising_edge(i_clock) then
    -- N_S
    o_d_n_e(15 downto 8)   <= (i_ct(71 downto 64) + 2*i_ct(63 downto 56) + i_ct(55 downto 48)) - (i_ct(23 downto 16) + 2*i_ct(15 downto 8) + i_ct(7 downto 0));
    -- E_W
    o_d_n_e(7 downto 0)    <= (i_ct(55 downto 48) + 2*i_ct(31 downto 24) + i_ct(7 downto 0)) - (i_ct(71 downto 64) + 2*i_ct(47 downto 40) + i_ct(23 downto 16));
    -- NE_SW
    o_d_ne_nw(15 downto 8) <= (i_ct(63 downto 56) + 2*i_ct(55 downto 48) + i_ct(31 downto 24)) - (i_ct(47 downto 40) + 2*i_ct(23 downto 16) + i_ct(15 downto 8));
    -- NW_SE
    o_d_nw_se(7 downto 0)  <= (i_ct(47 downto 40) + 2*i_ct(71 downto 64) + i_ct(63 downto 56)) - (i_ct(15 downto 8) + 2*i_ct(7 downto 0) + i_ct(31 downto 24));
  end if;
  
end process derivative;

end behavioral;


