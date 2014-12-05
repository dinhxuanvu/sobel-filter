-------------------------------------------------------------------------------
-- File: algorithm_tb.vhd
-- Entity: algorithm_tb
-- Architecture: Behavioral
-- Author: Vu Dinh
-- Created: 12/03/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a testbench
-- for algorithm module
-------------------------------------------------------------------------------
LIBRARY ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

entity algorithm_tb is
end algorithm_tb;

architecture behavioral of algorithm_tb is

component algorithm is
 port
  (
    i_enable     :    in  std_logic;
    i_d          :    in  std_logic_vector(21 downto 0);
    i_dir        :    in std_logic_vector(2 downto 0);
    o_edge       :    out std_logic;
    o_dir        :    out std_logic_vector(2 downto 0)
  );
end component;

constant  period       :   time := 50 ns;
constant  delay        :   time := 10 ns;

signal s_i_enable      :    std_logic;
signal s_clk           :    std_logic;
signal s_i_d           :    std_logic_vector(21 downto 0);
signal s_i_dir         :    std_logic_vector(2 downto 0);
signal s_o_edge        :    std_logic;
signal s_o_dir         :    std_logic_vector(2 downto 0);

file INFILE: TEXT open READ_MODE is "algorithm_data";
-- DERIVATIVE             DIR E DIR
-- XXXXXXXXXXXXXXXXXXXXXX XXX X XXX
-- XXXXXXXXXXXXXXXXXXXXXX XXX X XXX
begin
UUT: algorithm port map (s_i_enable, s_i_d, s_i_dir, s_o_edge, s_o_dir);
  
  test : process
  
  variable    v_line       :   line;
  variable    v_i_d        :   STD_LOGIC_VECTOR(21 DOWNTO 0);
  variable    v_i_dir      :   STD_LOGIC_VECTOR(2 DOWNTO 0);
  variable    v_o_edge     :   STD_LOGIC;
  variable    v_o_dir      :   STD_LOGIC_VECTOR(2 DOWNTO 0);
  begin
    while not(endfile(INFILE)) loop   -- While not end of file,
      
      wait until rising_edge(s_clk);
      
      readline(INFILE, v_line);       -- read line of a file.
      read(v_line, v_i_d);            -- Each READ procedure extracts data
      read(v_line, v_i_dir);          -- from the beginning of the string
      read(v_line, v_o_edge);         -- value designed by parameter v_line.
      read(v_line, v_o_dir);
      
      s_i_enable   <= '0';
      s_i_d        <= v_i_d;
      s_i_dir      <= v_i_dir;
   
      assert(v_o_edge = s_o_edge)
        report "Edge is not correct";
      assert(v_o_dir = s_o_dir)
        report "Direction is not correct";
    end loop;
    assert false
      report "done";
    wait;
  end process;
  
clock : process
begin
  s_clk <= '0';
  wait for period/2;
  s_clk <= '1';
  wait for period/2;
end process;
  		
end behavioral;