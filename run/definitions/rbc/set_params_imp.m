load params.mat;

#itermax = 20;

# save all parameters to be used in the Dynare file
save params.mat alpha beta delta rho rho_g g_bar Iz_bar rho_z xi itermax;
