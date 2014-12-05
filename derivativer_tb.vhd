-------------------------------------------------------------------------------
-- File: derivativer_tb.vhd
-- Entity: derivativer_tb
-- Architecture: Behavioral
-- Author: Vu Dinh
-- Created: 12/03/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a testbench
-- for derivative module
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_signed.all;

entity derivativer_tb is
end derivativer_tb;

architecture behavioral of derivativer_tb is

component derivativer is
  port
  (
    i_enable     :    in  std_logic;
    i_ct         :    in  std_logic_vector(71 downto 0);
    o_d_n_e      :    out std_logic_vector(21 downto 0);
    o_d_ne_nw    :    out std_logic_vector(21 downto 0)
  );
end component;

constant  period      :    time := 50 ns;
constant  delay       :    time := 10 ns;
signal s_i_enable     :    std_logic;
signal s_clk          :    std_logic;

signal s_i_ct         :    std_logic_vector(71 downto 0);
signal s_o_d_n_e      :    std_logic_vector(21 downto 0);
signal s_o_d_ne_nw    :    std_logic_vector(21 downto 0);


signal s_o_d_n_e_1    :    std_logic_vector(10 downto 0);
signal s_o_d_n_e_2    :    std_logic_vector(10 downto 0);

signal s_o_d_ne_nw_1  :    std_logic_vector(10 downto 0);
signal s_o_d_ne_nw_2  :    std_logic_vector(10 downto 0);

begin
UUT: derivativer port map (s_i_enable, s_i_ct, s_o_d_n_e, s_o_d_ne_nw);
  
test: process
begin
  s_i_enable <= '0';
  
  -- 150 255 15
  -- 120 250 50
  -- 75  235 75
  s_i_ct <= "100101101111111100001111011110001111101000110010010010111110101101001011";
  
  -- Result
  -- 55
  -- -275
  -- -170
  -- 240
    
  wait for delay;
  s_o_d_n_e_1 <= s_o_d_n_e(21 downto 11);
  s_o_d_n_e_2 <= s_o_d_n_e(10 downto 0);
  s_o_d_ne_nw_1 <= s_o_d_ne_nw(21 downto 11);
  s_o_d_ne_nw_2 <= s_o_d_ne_nw(10 downto 0);
  
  end process;

clock : process
begin
  s_clk <= '0';
  wait for period/2;
  s_clk <= '1';
  wait for period/2;
end process;
  		
end behavioral;