-------------------------------------------------
-- File: tb_comparator.vhd
-- Entity: tb_comparator
-- Architecture: behavioral
-- Author: Drew Carlstedt
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

entity tb_comparator is
end tb_comparator;
-------------------------------------------------

architecture behavioral of tb_comparator is

component comparator is
  port
  (
    i_enable     :    in  std_logic;
    i_d_n_e      :    in  std_logic_vector(21 downto 0);
    i_d_ne_nw    :    in  std_logic_vector(21 downto 0);
    o_d          :    out std_logic_vector(21 downto 0);
    o_dir        :    out std_logic_vector(2 downto 0)
  );
end component;

signal s_i_enable      :    std_logic;
signal s_clk           :    std_logic;
signal s_i_d_n_e       :    std_logic_vector(21 downto 0);
signal s_i_d_ne_nw     :    std_logic_vector(21 downto 0);
signal s_o_d           :    std_logic_vector(21 downto 0);
signal s_o_dir         :    std_logic_vector(2 downto 0);
constant  period       :    time := 50 ns;
constant  DELAY        :    time := 5 ns;

file INFILE: TEXT open READ_MODE is "tb_comparator_data";
--    N/E DERIVATIVE         NE/NW DERIVATIVE       OUTPUT DERIVATIVE   DIRECTION
-- XXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXX XXX -- format of the input file
-- XXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXX XXX

begin
UUT: comparator port map (s_i_enable, s_i_d_n_e, s_i_d_ne_nw, s_o_d, s_o_dir);
  
  verify : process
  variable    v_line       :   line; -- pointer to string
  variable    v_i_d_n_e    :   STD_LOGIC_VECTOR(21 DOWNTO 0);
  variable    v_i_d_ne_nw  :   STD_LOGIC_VECTOR(21 DOWNTO 0);
  variable    v_o_d        :   STD_LOGIC_VECTOR(21 DOWNTO 0);
  variable    v_o_dir      :   STD_LOGIC_VECTOR(2 DOWNTO 0);
  begin
    wait for DELAY;
    wait until rising_edge(s_clk);
    while not( endfile(INFILE)) loop  -- While not end of file,
      readline(INFILE, v_line);       -- read line of a file.
      read(v_line, v_i_d_n_e);    -- Each READ procedure extracts data
      read(v_line, v_i_d_ne_nw);  -- from the beginning of the string
      read(v_line, v_o_d);        -- value designed by parameter v_line.
      read(v_line, v_o_dir);
      s_i_enable     <= '1';
      s_i_d_n_e    <= v_i_d_n_e;
      s_i_d_ne_nw  <= v_i_d_ne_nw;
      wait for DELAY;
      assert( v_o_d=s_o_d )
        report "derivative is not correct";
      assert( v_o_dir=s_o_dir )
        report "direction is not correct";
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

