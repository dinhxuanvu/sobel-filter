-------------------------------------------------------------------------------
-- File: derivativer.vhd
-- Entity: derivativer
-- Architecture: Behavioral
-- Author: Drew Carlstedt, Vu Dinh
-- Created: 11/20/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a 4(3x3)
-- derivative module
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_signed.all;

entity derivativer is
  port
  (
    i_enable     :    in  std_logic;
    i_ct         :    in  std_logic_vector(71 downto 0);
    o_d_n_e      :    out std_logic_vector(21 downto 0);
    o_d_ne_nw    :    out std_logic_vector(21 downto 0)
  );
end derivativer;

-------------------------------------------------------------------------------
-- | 71 downto 64 | 63 downto 56 | 55 downto 48 |
-- | 47 downto 40 | 39 downto 32 | 31 downto 24 |
-- | 23 downto 16 | 15 downto 8  |  7 downto 0  |
architecture behavioral of derivativer is
  
begin
  
derivative : process (i_ct)

begin
    -- N_S
    o_d_n_e(21 downto 11)   <= ((("000" & i_ct(71 downto 64)) 
                              + ("00" & i_ct(63 downto 56) & "0") 
                              + ("000" & i_ct(55 downto 48))) 
                              - (("000" & i_ct(23 downto 16)) 
                              + ("00" & i_ct(15 downto 8) & "0")
                              + ("000" & i_ct(7 downto 0))));
    
    -- E_W
    o_d_n_e(10 downto 0)    <= ((("000" & i_ct(55 downto 48)) 
                              + ("00" & i_ct(31 downto 24) & "0") 
                              + ("000" & i_ct(7 downto 0))) 
                              - (("000" & i_ct(71 downto 64)) 
                              + ("00" & i_ct(47 downto 40) & "0")
                              + ("000" & i_ct(23 downto 16))));
                              
    -- NE_SW
    o_d_ne_nw(21 downto 11) <= ((("000" & i_ct(63 downto 56)) 
                              + ("00" & i_ct(55 downto 48) & "0") 
                              + ("000" & i_ct(31 downto 24))) 
                              - (("000" & i_ct(47 downto 40)) 
                              + ("00" & i_ct(23 downto 16) & "0")
                              + ("000" & i_ct(15 downto 8))));
    
    -- NW_SE
    o_d_ne_nw(10 downto 0)  <= ((("000" & i_ct(47 downto 40)) 
                              + ("00" & i_ct(71 downto 64) & "0") 
                              + ("000" & i_ct(63 downto 56))) 
                              - (("000" & i_ct(15 downto 8)) 
                              + ("00" & i_ct(7 downto 0) & "0")
                              + ("000" & i_ct(31 downto 24))));
  
end process derivative;

end behavioral;