# main script to run octave models

clear all;

# change working directory to the directory of this file                       
cur_path = strrep(mfilename("fullpath"), ["/" mfilename()], "");
eval(["cd " cur_path]);
 
set_params_exp;

# call Dynare to run model
dynare rbc_main.mod noclearall;

make_plot_vars;
