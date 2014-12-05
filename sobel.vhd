-------------------------------------------------------------------------------
-- File: sobel.vhd
-- Entity: sobel
-- Architecture: structural
-- Author: Drew Carlstedt, Vu Dinh
-- Created: 11/20/2014
-- VHDL'93
-- Description: The following is the entity and architecture of a sobel
-- edge detector
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity sobel is
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
end sobel;

-------------------------------------------------------------------------------

architecture structural of sobel is
  
component algorithm is
  port
  (
    i_enable     :    in  std_logic;
    i_clock      :    in  std_logic;
    i_d          :    in  std_logic_vector(21 downto 0);
    i_dir        :    in std_logic_vector(2 downto 0);
    o_edge       :    out std_logic;
    o_dir        :    out std_logic_vector(2 downto 0)
  );
end component;

component comparator is
  port
  (
    i_enable     :    in  std_logic;
    i_clock      :    in  std_logic;
    i_d_n_e      :    in  std_logic_vector(21 downto 0);
    i_d_ne_nw    :    in  std_logic_vector(21 downto 0);
    o_d          :    out std_logic_vector(21 downto 0);
    o_dir        :    out std_logic_vector(2 downto 0)
  );
end component;

component derivativer is
  port
  (
    i_reset      :    in  std_logic;
    i_clock      :    in  std_logic;
    i_ct         :    in  std_logic_vector(71 downto 0);
    o_d_n_e      :    out std_logic_vector(21 downto 0);
    o_d_ne_nw    :    out std_logic_vector(21 downto 0)
  );
end component;

component memory is
  port
  (
    i_enable      :    in  std_logic;
    i_clock       :    in  std_logic;
    i_pixel       :    in  std_logic_vector(7 downto 0);
    o_ct          :    out std_logic_vector(71 downto 0)
  );
end component;

component state is
  port
  (
    i_reset      :    in  std_logic;
    i_clock      :    in  std_logic;
    i_valid      :    in  std_logic;
    o_valid      :    out std_logic;
    o_mode       :    out std_logic_vector(1 downto 0);
    o_enable     :    out std_logic
  );
end component;

-- common signals
-- state signals
signal s_o_valid       :    std_logic;
signal s_o_mode        :    std_logic_vector(1 downto 0);
signal s_o_enable      :    std_logic;
-- memory signals
signal s_o_ct          :    std_logic_vector(71 downto 0);
-- derivativer signals
signal s_o_d_n_e       :    std_logic_vector(21 downto 0);
signal s_o_d_ne_nw     :    std_logic_vector(21 downto 0);
-- comparator signals
signal s_o_d           :    std_logic_vector(21 downto 0);
signal s_o_dir         :    std_logic_vector(2 downto 0);
-- algorithm signals

begin
  
  s: state       port map (i_reset,    i_clock, i_valid,   o_valid,     o_mode, s_o_enable);
  m: memory      port map (s_o_enable, i_clock, i_pixel,   s_o_ct                         );
  d: derivativer port map (s_o_enable, i_clock, s_o_ct,    s_o_d_n_e,   s_o_d_ne_nw       );
  c: comparator  port map (s_o_enable, i_clock, s_o_d_n_e, s_o_d_ne_nw, s_o_d,  s_o_dir   );
  a: algorithm   port map (s_o_enable, i_clock, s_o_d,     s_o_dir,     o_edge, o_dir     );
    
end structural;