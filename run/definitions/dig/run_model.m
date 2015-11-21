# main script to run octave models

clear all;

# change working directory to the directory of this file                       
cur_path = strrep(mfilename("fullpath"), ["/" mfilename()], "");
eval(["cd " cur_path]);

eval(["addpath " cur_path "/compecon"])
 
set_params_exp;
set_params_imp;

calc_steady_state;

# call Dynare to run model
dynare dig_main.mod noclearall;

make_plot_vars;

eval(["rmpath " cur_path "/compecon"])
