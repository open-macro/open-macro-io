# housekeeping                                                                 
clear all;

# change working directory to the directory of this file                       
cur_path = strrep(mfilename("fullpath"), ["/" mfilename()], "");
eval(["cd " cur_path]);

# add compecon methods to Octave path
eval(["addpath " cur_path "/compecon"])
 
# set and save parameters (both explicit and implicit)                         
set_params;
set_params_imp;

# find steady state of model
calc_steady_state;

# run model
dynare dsf.mod noclearall;
results = "plot_vars";
make_plot_vars;

# housekeeping
eval(["rmpath " cur_path "/compecon"])
