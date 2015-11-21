inc         = 1;
incdc       = 1;
incb        = 1;
inciz       = 0;
incgrants   = 1;
incremit    = 1;
P_x         = P_xo;
P_mm        = P_mmo;
P_m         = P_mo;

% initial guess

x0 = [bstaro eo+eho (1-rho_x-rho_m)*(eo+eho) eo eho ho (delta_n+g)*k_no (delta_x+g)*k_xo k_no k_xo L_no L_xo  Po P_ko P_no P_zo ro r_no r_xo To q_no q_xo wo yo zo zeo]';

% use Broyden Method to Solve the System of Equations

x = broyden('steady_state',x0,beta_t,delta_x,delta_n,delta_z,tau,psi_x,psi_n,xi_n,xi_x,alpha_x,alpha_n,g,epsilon,eta,ho,rstar,s,rho_x,rho_m,a_k,a_z,miu,ro,To,d_o,bo,zo,P_zo,P_x,P_mm,P_m,a_n,a_x,inc,r_dco,incdc,dco,incb,inciz,lambda,eo,eho,s_s,a_ratio,remito,grantso,oilro,i_zo,Lo,incgrants,incremit,sigma_x,sigma_n,nu,bstaro,q_no,q_xo,yo,etag,nug);

x = real(x);

[f, xss] = steady_state(x,beta_t,delta_x,delta_n,delta_z,tau,psi_x,psi_n,xi_n,xi_x,alpha_x,alpha_n,g,epsilon,eta,ho,rstar,s,rho_x,rho_m,a_k,a_z,miu,ro,To,d_o,bo,zo,P_zo,P_x,P_mm,P_m,a_n,a_x,inc,r_dco,incdc,dco,incb,inciz,lambda,eo,eho,s_s,a_ratio,remito,grantso,oilro,i_zo,Lo,incgrants,incremit,sigma_x,sigma_n,nu,bstaro,q_no,q_xo,yo,etag,nug);

bstar_ini = xss(1);
c_ini     = xss(2);
c_n_ini   = xss(3);
e_ini     = xss(4);
eh_ini    = xss(5);
h_ini     = xss(6);
i_n_ini   = xss(7);
i_x_ini   = xss(8);
k_n_ini   = xss(9);
k_x_ini   = xss(10);
L_n_ini   = xss(11);
L_x_ini   = xss(12);
P_ini     = xss(13);
P_k_ini   = xss(14);
P_n_ini   = xss(15);
P_z_ini   = xss(16);
r_ini     = xss(17);
r_n_ini   = xss(18);
r_x_ini   = xss(19);
T_ini     = xss(20);
q_n_ini   = xss(21);
q_x_ini   = xss(22);
w_ini     = xss(23);
y_ini     = xss(24);
z_ini     = xss(25);
ze_ini    = xss(26);

R_z_ini = (psi_x*P_x*q_x_ini + psi_n*P_n_ini*q_n_ini)/(P_z_ini*ze_ini);
i_z_ini = (delta_z+g)*z_ini;
b_ini   = bo;
d_ini   = d_o;
dc_ini  = dco;

save steady_state_values.mat b_ini d_ini dc_ini bstar_ini c_ini e_ini ...
    eh_ini h_ini i_n_ini i_x_ini i_z_ini k_n_ini k_x_ini L_n_ini ...
    L_x_ini P_ini P_k_ini P_n_ini P_z_ini r_ini r_n_ini r_x_ini ...
    R_z_ini q_n_ini q_x_ini w_ini z_ini T_ini ze_ini
