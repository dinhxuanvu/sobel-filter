-------------------------------------------------
-- File: sobel_tb.vhd
-- Entity: sobel_tb
-- Architecture: behavioral
-- Author: Drew Carlstedt, Vu Dinh
-- Created: 12/3/2014
-- VHDL'93
-- Description: The following is the entity and
-- architecture of testbench for a the comparison
-- module of the sobel edge detector
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

entity sobel_tb is
end sobel_tb;
-------------------------------------------------

architecture behavioral of sobel_tb is

component sobel is
  port
  (
    i_reset      :    in  std_logic;
    i_clock      :    in  std_logic;
    i_valid      :    in  std_logic;
    i_pixel      :    in  std_logic_vector(7 downto 0);
    o_edge       :    out std_logic;
    o_dir        :    out std_logic_vector(2 downto 0);
    o_valid      :    out std_logic;
    o_mode       :    out std_logic_vector(1 downto 0)
  );
end component;

signal s_i_reset       :    std_logic;
signal s_clk           :    std_logic;
signal s_i_valid       :    std_logic;
signal s_i_pixel       :    std_logic_vector(7 downto 0);
signal s_o_edge        :    std_logic;
signal s_o_dir         :    std_logic_vector(2 downto 0);
signal s_o_valid       :    std_logic;
signal s_o_mode        :    std_logic_vector(1 downto 0);
constant  period       :   time := 50 ns;
constant  DELAY        :   time := 5 ns;

file INFILE: TEXT open READ_MODE is "sobel_data";
--    N/E DERIVATIVE         NE/NW DERIVATIVE       OUTPUT DERIVATIVE   DIRECTION
-- XXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXX XXX -- format of the input file
-- XXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXX XXX
begin
UUT: sobel port map (s_i_reset, s_clk, s_i_valid, s_i_pixel, s_o_edge, s_o_dir, s_o_valid, s_o_mode);
  
  verify : process
  variable    v_line       :   line; -- pointer to string
  variable v_i_valid       :   std_logic;
  variable v_i_pixel       :   std_logic_vector(7 downto 0);
  variable v_o_edge        :   std_logic;
  variable v_o_dir         :   std_logic_vector(2 downto 0);
  variable v_o_valid       :   std_logic;
  variable v_o_mode        :   std_logic_vector(1 downto 0);
  begin
    wait for DELAY;
    -- FIXME THIS NEEDS TO DO THE FILE IMAGE READING STUFF
    while not( endfile(INFILE)) loop  -- While not end of file,
      readline(INFILE, v_line);       -- read line of a file.
      read(v_line, v_i_valid);    -- Each READ procedure extracts data
      read(v_line, v_i_pixel);    -- from the beginning of the string
      read(v_line, v_o_edge);     -- value designed by parameter v_line.
      read(v_line, v_o_dir);
      read(v_line, v_o_valid);
      read(v_line, v_o_mode);
      s_i_valid  <= v_i_valid;
      s_i_pixel  <= v_i_pixel;
      wait for DELAY;
      assert( v_o_edge=s_o_edge)
        report "edge is not correct";
      assert( v_o_dir=s_o_dir )
        report "direction is not correct";
      assert( v_o_valid=s_o_valid )
        report "valid is not correct";
      assert( v_o_mode=s_o_mode )
        report "mode is not correct";
      wait until rising_edge(s_clk);-- s_clk'EVENT;
    end loop;
    assert false
      report "done";
    wait;
  end process verify;
  
clock : process
begin
  s_clk <= '0';
  wait for period/2;
  s_clk <= '1';
  wait for period/2;
end process;
  		
end behavioral;


