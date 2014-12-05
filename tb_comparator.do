vsim work.tb_comparator
add wave -position insertpoint  \
sim/:tb_comparator:s_clk \
sim/:tb_comparator:s_i_d_n_e \
sim/:tb_comparator:s_i_d_ne_nw \
sim/:tb_comparator:s_o_d \
sim/:tb_comparator:s_o_dir

run 400ns
