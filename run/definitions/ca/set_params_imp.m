load params.mat;

#itermax = 20;

# explicitly defined parameters
rho3   = exp(-rho1*dbar)+rho2*dbar;
beta   = 1/(1+rbar+(psi/rho1^2)*(1-rho3+dbar*(rho1-rho2)));
g      = (1+g_n)*(1 + g_a)-1;
y_0    = 1;
T_0    = 0;
vv_0   = 0; 
gov_0  = gov_exp_0 - gov_inv_0;  
invk_0 = inv_0 - gov_inv_0;     
invs_0 = gov_inv_0;             
f_0    = - d_0;
r_0    = rbar+(psi/(rho1^2))*(exp(rho1*(d_0-dbar-omega*vv_0))-rho2*(d_0-dbar-omega*vv_0)-rho3);
govt_c = gov_0/c_0;             
kappa  = (govt_c)^gamma; 
phi_k0 = 0.25;  
phi_s0 = 0.25; 

# use fsolve iterative solver to find phi_k and phi_s
# must use function handles to include extra parameters
phi_k = fsolve(@(phi_k0) costoverrun(phi_k0, cost_k0, delta_k, e_k, g, invk_0, k_0), phi_k0);
phi_s = fsolve(@(phi_s0) costoverrun(phi_s0, cost_s0, delta_s, e_s, g, invs_0, s_0), phi_s0);

# use iterative solver to find Abar that corresponds with yss = 1
calc_Abar;

# now solve for the final steady state
calc_sstate;

# save all parameters to be used in the Dynare file
save params.mat theta_k theta_s gamma delta_k delta_s beta kappa Abar ...
     e_k e_s phi_k phi_s rbar psi rho1 rho2 rho3 omega dbar g_n g_a g xi ...
     fvalue dvalue kvalue svalue ikvalue isvalue cvalue yoilvalue vvvalue ...
     govvalue ynonvalue tbvalue cavalue yvalue yoil_0 f_0 r_0 d_0 invk_0 ...
     invs_0  k_0 s_0 c_0 ca_0 gov_0 T_0 itermax;
