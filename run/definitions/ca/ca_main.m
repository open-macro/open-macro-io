%
% Status : main Dynare file 
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

tic;
global M_ oo_ options_ ys0_ ex0_ estimation_info
options_ = [];
M_.fname = 'ca_main';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('ca_main.log');
M_.exo_names = 'e_yoil0';
M_.exo_names_tex = 'e\_yoil0';
M_.exo_names_long = 'e_yoil0';
M_.exo_names = char(M_.exo_names, 'e_yoil1');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_yoil1');
M_.exo_names_long = char(M_.exo_names_long, 'e_yoil1');
M_.exo_names = char(M_.exo_names, 'e_yoil0_neg');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_yoil0\_neg');
M_.exo_names_long = char(M_.exo_names_long, 'e_yoil0_neg');
M_.exo_names = char(M_.exo_names, 'e_yoil1_neg');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_yoil1\_neg');
M_.exo_names_long = char(M_.exo_names_long, 'e_yoil1_neg');
M_.exo_names = char(M_.exo_names, 'e_T0');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_T0');
M_.exo_names_long = char(M_.exo_names_long, 'e_T0');
M_.exo_names = char(M_.exo_names, 'e_T1');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_T1');
M_.exo_names_long = char(M_.exo_names_long, 'e_T1');
M_.exo_names = char(M_.exo_names, 'e_T0_neg');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_T0\_neg');
M_.exo_names_long = char(M_.exo_names_long, 'e_T0_neg');
M_.exo_names = char(M_.exo_names, 'e_T1_neg');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_T1\_neg');
M_.exo_names_long = char(M_.exo_names_long, 'e_T1_neg');
M_.exo_names = char(M_.exo_names, 'e_Abar0');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_Abar0');
M_.exo_names_long = char(M_.exo_names_long, 'e_Abar0');
M_.exo_names = char(M_.exo_names, 'e_Abar1');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_Abar1');
M_.exo_names_long = char(M_.exo_names_long, 'e_Abar1');
M_.exo_names = char(M_.exo_names, 'e_Abar0_neg');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_Abar0\_neg');
M_.exo_names_long = char(M_.exo_names_long, 'e_Abar0_neg');
M_.exo_names = char(M_.exo_names, 'e_Abar1_neg');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_Abar1\_neg');
M_.exo_names_long = char(M_.exo_names_long, 'e_Abar1_neg');
M_.endo_names = 'c';
M_.endo_names_tex = 'c';
M_.endo_names_long = 'c';
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names_long = char(M_.endo_names_long, 'k');
M_.endo_names = char(M_.endo_names, 's');
M_.endo_names_tex = char(M_.endo_names_tex, 's');
M_.endo_names_long = char(M_.endo_names_long, 's');
M_.endo_names = char(M_.endo_names, 'invk');
M_.endo_names_tex = char(M_.endo_names_tex, 'invk');
M_.endo_names_long = char(M_.endo_names_long, 'invk');
M_.endo_names = char(M_.endo_names, 'invs');
M_.endo_names_tex = char(M_.endo_names_tex, 'invs');
M_.endo_names_long = char(M_.endo_names_long, 'invs');
M_.endo_names = char(M_.endo_names, 'd');
M_.endo_names_tex = char(M_.endo_names_tex, 'd');
M_.endo_names_long = char(M_.endo_names_long, 'd');
M_.endo_names = char(M_.endo_names, 'f');
M_.endo_names_tex = char(M_.endo_names_tex, 'f');
M_.endo_names_long = char(M_.endo_names_long, 'f');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names_long = char(M_.endo_names_long, 'r');
M_.endo_names = char(M_.endo_names, 'ca');
M_.endo_names_tex = char(M_.endo_names_tex, 'ca');
M_.endo_names_long = char(M_.endo_names_long, 'ca');
M_.endo_names = char(M_.endo_names, 'tb');
M_.endo_names_tex = char(M_.endo_names_tex, 'tb');
M_.endo_names_long = char(M_.endo_names_long, 'tb');
M_.endo_names = char(M_.endo_names, 'ynon');
M_.endo_names_tex = char(M_.endo_names_tex, 'ynon');
M_.endo_names_long = char(M_.endo_names_long, 'ynon');
M_.endo_names = char(M_.endo_names, 'y');
M_.endo_names_tex = char(M_.endo_names_tex, 'y');
M_.endo_names_long = char(M_.endo_names_long, 'y');
M_.endo_names = char(M_.endo_names, 'vv');
M_.endo_names_tex = char(M_.endo_names_tex, 'vv');
M_.endo_names_long = char(M_.endo_names_long, 'vv');
M_.endo_names = char(M_.endo_names, 'gov');
M_.endo_names_tex = char(M_.endo_names_tex, 'gov');
M_.endo_names_long = char(M_.endo_names_long, 'gov');
M_.endo_names = char(M_.endo_names, 'AC_s');
M_.endo_names_tex = char(M_.endo_names_tex, 'AC\_s');
M_.endo_names_long = char(M_.endo_names_long, 'AC_s');
M_.endo_names = char(M_.endo_names, 'AC_k');
M_.endo_names_tex = char(M_.endo_names_tex, 'AC\_k');
M_.endo_names_long = char(M_.endo_names_long, 'AC_k');
M_.endo_names = char(M_.endo_names, 'govh');
M_.endo_names_tex = char(M_.endo_names_tex, 'govh');
M_.endo_names_long = char(M_.endo_names_long, 'govh');
M_.endo_names = char(M_.endo_names, 'yoil');
M_.endo_names_tex = char(M_.endo_names_tex, 'yoil');
M_.endo_names_long = char(M_.endo_names_long, 'yoil');
M_.endo_names = char(M_.endo_names, 'ch');
M_.endo_names_tex = char(M_.endo_names_tex, 'ch');
M_.endo_names_long = char(M_.endo_names_long, 'ch');
M_.endo_names = char(M_.endo_names, 'T');
M_.endo_names_tex = char(M_.endo_names_tex, 'T');
M_.endo_names_long = char(M_.endo_names_long, 'T');
M_.endo_names = char(M_.endo_names, 'A');
M_.endo_names_tex = char(M_.endo_names_tex, 'A');
M_.endo_names_long = char(M_.endo_names_long, 'A');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LEAD_33');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LEAD\_33');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LEAD_33');
M_.param_names = 'theta_k';
M_.param_names_tex = 'theta\_k';
M_.param_names_long = 'theta_k';
M_.param_names = char(M_.param_names, 'theta_s');
M_.param_names_tex = char(M_.param_names_tex, 'theta\_s');
M_.param_names_long = char(M_.param_names_long, 'theta_s');
M_.param_names = char(M_.param_names, 'gamma');
M_.param_names_tex = char(M_.param_names_tex, 'gamma');
M_.param_names_long = char(M_.param_names_long, 'gamma');
M_.param_names = char(M_.param_names, 'delta_k');
M_.param_names_tex = char(M_.param_names_tex, 'delta\_k');
M_.param_names_long = char(M_.param_names_long, 'delta_k');
M_.param_names = char(M_.param_names, 'delta_s');
M_.param_names_tex = char(M_.param_names_tex, 'delta\_s');
M_.param_names_long = char(M_.param_names_long, 'delta_s');
M_.param_names = char(M_.param_names, 'beta');
M_.param_names_tex = char(M_.param_names_tex, 'beta');
M_.param_names_long = char(M_.param_names_long, 'beta');
M_.param_names = char(M_.param_names, 'kappa');
M_.param_names_tex = char(M_.param_names_tex, 'kappa');
M_.param_names_long = char(M_.param_names_long, 'kappa');
M_.param_names = char(M_.param_names, 'e_k');
M_.param_names_tex = char(M_.param_names_tex, 'e\_k');
M_.param_names_long = char(M_.param_names_long, 'e_k');
M_.param_names = char(M_.param_names, 'e_s');
M_.param_names_tex = char(M_.param_names_tex, 'e\_s');
M_.param_names_long = char(M_.param_names_long, 'e_s');
M_.param_names = char(M_.param_names, 'phi_k');
M_.param_names_tex = char(M_.param_names_tex, 'phi\_k');
M_.param_names_long = char(M_.param_names_long, 'phi_k');
M_.param_names = char(M_.param_names, 'phi_s');
M_.param_names_tex = char(M_.param_names_tex, 'phi\_s');
M_.param_names_long = char(M_.param_names_long, 'phi_s');
M_.param_names = char(M_.param_names, 'rbar');
M_.param_names_tex = char(M_.param_names_tex, 'rbar');
M_.param_names_long = char(M_.param_names_long, 'rbar');
M_.param_names = char(M_.param_names, 'psi');
M_.param_names_tex = char(M_.param_names_tex, 'psi');
M_.param_names_long = char(M_.param_names_long, 'psi');
M_.param_names = char(M_.param_names, 'rho1');
M_.param_names_tex = char(M_.param_names_tex, 'rho1');
M_.param_names_long = char(M_.param_names_long, 'rho1');
M_.param_names = char(M_.param_names, 'rho2');
M_.param_names_tex = char(M_.param_names_tex, 'rho2');
M_.param_names_long = char(M_.param_names_long, 'rho2');
M_.param_names = char(M_.param_names, 'rho3');
M_.param_names_tex = char(M_.param_names_tex, 'rho3');
M_.param_names_long = char(M_.param_names_long, 'rho3');
M_.param_names = char(M_.param_names, 'omega');
M_.param_names_tex = char(M_.param_names_tex, 'omega');
M_.param_names_long = char(M_.param_names_long, 'omega');
M_.param_names = char(M_.param_names, 'dbar');
M_.param_names_tex = char(M_.param_names_tex, 'dbar');
M_.param_names_long = char(M_.param_names_long, 'dbar');
M_.param_names = char(M_.param_names, 'g_n');
M_.param_names_tex = char(M_.param_names_tex, 'g\_n');
M_.param_names_long = char(M_.param_names_long, 'g_n');
M_.param_names = char(M_.param_names, 'g_a');
M_.param_names_tex = char(M_.param_names_tex, 'g\_a');
M_.param_names_long = char(M_.param_names_long, 'g_a');
M_.param_names = char(M_.param_names, 'g');
M_.param_names_tex = char(M_.param_names_tex, 'g');
M_.param_names_long = char(M_.param_names_long, 'g');
M_.param_names = char(M_.param_names, 'xi');
M_.param_names_tex = char(M_.param_names_tex, 'xi');
M_.param_names_long = char(M_.param_names_long, 'xi');
M_.param_names = char(M_.param_names, 'Abar');
M_.param_names_tex = char(M_.param_names_tex, 'Abar');
M_.param_names_long = char(M_.param_names_long, 'Abar');
M_.param_names = char(M_.param_names, 'yoil_0');
M_.param_names_tex = char(M_.param_names_tex, 'yoil\_0');
M_.param_names_long = char(M_.param_names_long, 'yoil_0');
M_.param_names = char(M_.param_names, 'f_0');
M_.param_names_tex = char(M_.param_names_tex, 'f\_0');
M_.param_names_long = char(M_.param_names_long, 'f_0');
M_.param_names = char(M_.param_names, 'r_0');
M_.param_names_tex = char(M_.param_names_tex, 'r\_0');
M_.param_names_long = char(M_.param_names_long, 'r_0');
M_.param_names = char(M_.param_names, 'd_0');
M_.param_names_tex = char(M_.param_names_tex, 'd\_0');
M_.param_names_long = char(M_.param_names_long, 'd_0');
M_.param_names = char(M_.param_names, 'invk_0');
M_.param_names_tex = char(M_.param_names_tex, 'invk\_0');
M_.param_names_long = char(M_.param_names_long, 'invk_0');
M_.param_names = char(M_.param_names, 'invs_0');
M_.param_names_tex = char(M_.param_names_tex, 'invs\_0');
M_.param_names_long = char(M_.param_names_long, 'invs_0');
M_.param_names = char(M_.param_names, 'k_0');
M_.param_names_tex = char(M_.param_names_tex, 'k\_0');
M_.param_names_long = char(M_.param_names_long, 'k_0');
M_.param_names = char(M_.param_names, 's_0');
M_.param_names_tex = char(M_.param_names_tex, 's\_0');
M_.param_names_long = char(M_.param_names_long, 's_0');
M_.param_names = char(M_.param_names, 'c_0');
M_.param_names_tex = char(M_.param_names_tex, 'c\_0');
M_.param_names_long = char(M_.param_names_long, 'c_0');
M_.param_names = char(M_.param_names, 'ca_0');
M_.param_names_tex = char(M_.param_names_tex, 'ca\_0');
M_.param_names_long = char(M_.param_names_long, 'ca_0');
M_.param_names = char(M_.param_names, 'gov_0');
M_.param_names_tex = char(M_.param_names_tex, 'gov\_0');
M_.param_names_long = char(M_.param_names_long, 'gov_0');
M_.param_names = char(M_.param_names, 'T_0');
M_.param_names_tex = char(M_.param_names_tex, 'T\_0');
M_.param_names_long = char(M_.param_names_long, 'T_0');
M_.exo_det_nbr = 0;
M_.exo_nbr = 12;
M_.endo_nbr = 22;
M_.param_nbr = 35;
M_.orig_endo_nbr = 21;
M_.aux_vars(1).endo_index = 22;
M_.aux_vars(1).type = 0;
M_.Sigma_e = zeros(12, 12);
M_.Correlation_matrix = eye(12, 12);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('ca_main_static');
erase_compiled_function('ca_main_dynamic');
M_.lead_lag_incidence = [
 0 7 29;
 1 8 30;
 2 9 31;
 0 10 0;
 0 11 0;
 3 12 0;
 0 13 0;
 4 14 0;
 0 15 0;
 0 16 0;
 0 17 0;
 0 18 0;
 0 19 32;
 0 20 33;
 0 21 0;
 0 22 0;
 5 23 0;
 0 24 0;
 6 25 0;
 0 26 0;
 0 27 0;
 0 28 34;]';
M_.nstatic = 12;
M_.nfwrd   = 4;
M_.npred   = 4;
M_.nboth   = 2;
M_.nsfwrd   = 6;
M_.nspred   = 6;
M_.ndynamic   = 10;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:12];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(22, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(12, 1);
M_.params = NaN(35, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 103;
M_.NNZDerivatives(2) = 0;
M_.NNZDerivatives(3) = -1;
load params.mat;   
for i=1:length(M_.params)
parameter_name = M_.param_names(i,:);
eval(['M_.params(i)  = ' parameter_name ' ;']);
end;   
options_.maxit = itermax;
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 3 ) = M_.params(31);
oo_.steady_state( 2 ) = M_.params(30);
oo_.steady_state( 11 ) = M_.params(23)*oo_.steady_state(2)^M_.params(1)*oo_.steady_state(3)^M_.params(2);
oo_.steady_state( 18 ) = M_.params(24);
oo_.steady_state( 12 ) = oo_.steady_state(11)+oo_.steady_state(18);
oo_.steady_state( 7 ) = M_.params(25)*oo_.steady_state(12);
oo_.steady_state( 8 ) = M_.params(26);
oo_.steady_state( 4 ) = oo_.steady_state(12)*0.8*M_.params(28);
oo_.steady_state( 5 ) = oo_.steady_state(12)*0.8*M_.params(29);
oo_.steady_state( 13 ) = vvvalue;
oo_.steady_state( 16 ) = oo_.steady_state(12)*M_.params(28)*0.2;
oo_.steady_state( 15 ) = oo_.steady_state(12)*M_.params(29)*0.2;
oo_.steady_state( 9 ) = oo_.steady_state(12)*M_.params(33);
oo_.steady_state( 6 ) = M_.params(27)*y_0;
oo_.steady_state( 17 ) = oo_.steady_state(12)*M_.params(34);
oo_.steady_state( 14 ) = (1-M_.params(22))*oo_.steady_state(17);
oo_.steady_state( 19 ) = oo_.steady_state(12)*M_.params(32);
oo_.steady_state( 1 ) = (1-M_.params(22))*oo_.steady_state(19);
oo_.steady_state( 20 ) = oo_.steady_state(12)*M_.params(35);
oo_.steady_state( 10 ) = oo_.steady_state(9)+oo_.steady_state(8)*oo_.steady_state(6)-oo_.steady_state(20);
oo_.steady_state( 21 ) = M_.params(23);
oo_.steady_state(22)=oo_.steady_state(1);
if M_.exo_nbr > 0;
	oo_.exo_simul = [ones(M_.maximum_lag,1)*oo_.exo_steady_state'];
end;
if M_.exo_det_nbr > 0;
	oo_.exo_det_simul = [ones(M_.maximum_lag,1)*oo_.exo_det_steady_state'];
end;
%
% SHOCKS instructions
%
make_ex_;
set_shocks(0,1, 1, 0.01);
set_shocks(0,2, 1, 0);
set_shocks(0,3, 1, 0);
set_shocks(0,4, 1, 0);
set_shocks(0,5, 1, 0);
set_shocks(0,6, 1, 0);
set_shocks(0,7, 1, 0);
set_shocks(0,8, 1, 0);
set_shocks(0,9, 1, 0);
set_shocks(0,10, 1, 0);
set_shocks(0,11, 1, 0);
set_shocks(0,12, 1, 0);
set_shocks(0,13, 1, 0);
set_shocks(0,14, 1, 0);
set_shocks(0,15, 1, 0);
set_shocks(0,16, 1, 0);
set_shocks(0,17, 1, 0);
set_shocks(0,18, 1, 0);
set_shocks(0,19, 1, 0);
set_shocks(0,20, 1, 0);
set_shocks(0,21, 1, 0);
set_shocks(0,22, 1, 0);
set_shocks(0,23, 1, 0);
set_shocks(0,24, 1, 0);
set_shocks(0,25, 1, 0);
set_shocks(0,26, 1, 0);
set_shocks(0,27, 1, 0);
set_shocks(0,28, 1, 0);
set_shocks(0,29, 1, 0);
set_shocks(0,30, 1, 0);
M_.exo_det_length = 0;
M_.sigma_e_is_diagonal = 1;
options_.debug=1;
options_.periods = 1000;
simul();
save('ca_main_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('ca_main_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('ca_main_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('ca_main_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('ca_main_results.mat', 'estimation_info', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
