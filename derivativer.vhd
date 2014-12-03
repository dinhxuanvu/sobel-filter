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
    i_ct         :    in  std_logic_vector(71 downto 0);
    o_d_n_e      :    out std_logic_vector(19 downto 0);
    o_d_ne_nw    :    out std_logic_vector(19 downto 0)
  );
end derivativer;

-------------------------------------------------------------------------------
-- | 71 downto 64 | 63 downto 56 | 55 downto 48 |
-- | 47 downto 40 | 39 downto 32 | 31 downto 24 |
-- | 23 downto 16 | 15 downto 8  |  7 downto 0  |
architecture behavioral of derivativer is

component adder
  port
  (
    i_reset      :    in  std_logic;
    i_clock      :    in  std_logic;
    i_c          :    in  std_logic;
    i_x          :    in  std_logic_vector(9 downto 0);
    i_y          :    in  std_logic_vector(9 downto 0);
    o_z          :    out std_logic_vector(9 downto 0);
    o_c          :    out std_logic
  );
end component;
  
begin
  
derivative : process (i_clock)

variable sum_temp1 : std_logic_vector(9 downto 0);
variable sum_temp2 : std_logic_vector(9 downto 0);
variable sum_temp3 : std_logic_vector(9 downto 0);
variable sum_temp4 : std_logic_vector(9 downto 0);

variable cout_temp1 : std_logic;
variable cout_temp2 : std_logic;
variable cout_temp3 : std_logic;
variable cout_temp4 : std_logic;
variable cout_temp5 : std_logic;

variable mult_temp1 : std_logic_vector(9 downto 0);
variable mult_temp2 : std_logic_vector(9 downto 0);

begin
  
  if rising_edge(i_clock) then
    -- N_S
    mult_temp1 := resize(2*i_ct(63 downto 56),8);
    mult_temp2 := resize(2*i_ct(15 downto 8),8);
    
    D1: adder port map (i_clock,i_clock,'0',i_ct(71 downto 64),mult_temp1,sum_temp1,cout_temp1);
    D2: adder port map (i_clock,i_clock,cout_temp1,i_ct(55 downto 48),sum_temp1,sum_temp2,cout_temp2); 
      
    D3: adder port map (i_clock,i_clock,'0',i_ct(23 downto 16),mult_temp2,sum_temp3,cout_temp3); 
    D4: adder port map (i_clock,i_clock,cout_temp3,i_ct(7 downto 0),sum_temp3,sum_temp4,cout_temp4); 
      
    cout_temp5 := cout_temp2 OR cout_temp4;
    
    D5: adder port map (i_clock,i_clock,cout_temp1,i_ct(71 downto 64),mult_temp1,sum_temp2,cout_temp2); 
    
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


