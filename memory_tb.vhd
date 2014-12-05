-------------------------------------------------------------------------------
-- File: memory_tb.vhd
-- Entity: memory_tb
-- Architecture: Behavioral
-- Author: Vu Dinh
-- Created: 12/03/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a testbench
-- for memory module
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity memory_tb is
end memory_tb;

architecture behavioral of memory_tb is

component memory is
  port
  (
    i_enable      :    in  std_logic;
    i_clock       :    in  std_logic;
    i_pixel0      :    in  std_logic_vector(7 downto 0);
    i_pixel1      :    in  std_logic_vector(7 downto 0);
    i_pixel2      :    in  std_logic_vector(7 downto 0);
    i_pixel3      :    in  std_logic_vector(7 downto 0);
    i_pixel4      :    in  std_logic_vector(7 downto 0);
    i_pixel5      :    in  std_logic_vector(7 downto 0);
    i_pixel6      :    in  std_logic_vector(7 downto 0);
    i_pixel7      :    in  std_logic_vector(7 downto 0);
    i_pixel8      :    in  std_logic_vector(7 downto 0);
    o_ct          :    out std_logic_vector(71 downto 0)
  );
end component;

constant  period  :   time := 50 ns;
constant  delay   :   time := 10 ns;
signal s_i_enable :    std_logic;
signal s_clk      :    std_logic;

signal s_i_pixel0      :    std_logic_vector(7 downto 0);
signal s_i_pixel1      :    std_logic_vector(7 downto 0);
signal s_i_pixel2      :    std_logic_vector(7 downto 0);
signal s_i_pixel3      :    std_logic_vector(7 downto 0);
signal s_i_pixel4      :    std_logic_vector(7 downto 0);
signal s_i_pixel5      :    std_logic_vector(7 downto 0);
signal s_i_pixel6      :    std_logic_vector(7 downto 0);
signal s_i_pixel7      :    std_logic_vector(7 downto 0);
signal s_i_pixel8      :    std_logic_vector(7 downto 0);

signal s_o_ct          :    std_logic_vector(71 downto 0);

signal pixel0      :    std_logic_vector(7 downto 0);
signal pixel1      :    std_logic_vector(7 downto 0);
signal pixel2      :    std_logic_vector(7 downto 0);
signal pixel3      :    std_logic_vector(7 downto 0);
signal pixel4      :    std_logic_vector(7 downto 0);
signal pixel5      :    std_logic_vector(7 downto 0);
signal pixel6      :    std_logic_vector(7 downto 0);
signal pixel7      :    std_logic_vector(7 downto 0);
signal pixel8      :    std_logic_vector(7 downto 0);

begin
UUT: memory port map (s_i_enable, s_clk, s_i_pixel0, s_i_pixel1, s_i_pixel2, 
s_i_pixel3, s_i_pixel4, s_i_pixel5, s_i_pixel6, s_i_pixel7, s_i_pixel8, s_o_ct);
  
test: process
begin
  s_i_enable <= '0';
  
  -- 150 255 15
  -- 120 250 50
  -- 75  235 75
  
  s_i_pixel0 <= "01001011";
  s_i_pixel1 <= "11101011";
  s_i_pixel2 <= "01001011";
  s_i_pixel3 <= "00110010";
  s_i_pixel4 <= "11111010";
  s_i_pixel5 <= "01111000";
  s_i_pixel6 <= "00001111";
  s_i_pixel7 <= "11111111";
  s_i_pixel8 <= "10010110";
    
  wait for delay;
  pixel0 <= s_o_ct(7 downto 0);
  pixel1 <= s_o_ct(15 downto 8);
  pixel2 <= s_o_ct(23 downto 16);
  pixel3 <= s_o_ct(31 downto 24);
  pixel4 <= s_o_ct(39 downto 32);
  pixel5 <= s_o_ct(47 downto 40);
  pixel6 <= s_o_ct(55 downto 48);
  pixel7 <= s_o_ct(63 downto 56);
  pixel8<= s_o_ct(71 downto 64);
  
  end process;

clock : process
begin
  s_clk <= '0';
  wait for period/2;
  s_clk <= '1';
  wait for period/2;
end process;
  		
end behavioral;
