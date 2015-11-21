# set implicit parameters

load params.mat

#itermax = 20;

beta    = ((1+g)^(1/tau))/(1+ro);
beta_t  = (beta*(1+g)^(1-1/tau));
yo      = 100;
bo      = share_b*yo;
bstaro  = share_bstar*yo;
d_o     = share_d*yo;
dco     = share_dc*yo;
P_no    = 1;
P_xo    = 1;
P_mo    = 1;
P_mmo   = 1;
Po      = 1;
wo      = 1;
P_ko    = 1/(1-alpha_k);
P_zo    = 1/(1-alpha_z);
a_k     = alpha_k/(1-alpha_k);
a_z     = alpha_z/(1-alpha_z);
ro      = ((1+g)^(1/tau))/beta-1;
r_xo    = P_ko*(ro+delta_x);
r_no    = P_ko*(ro+delta_n);
miu     = fo*P_zo*delta_z;
nu_x    = 1/((delta_x+g)*omega);
nu_n    = 1/((delta_n + g)*omega);
zo      = izy*yo/(P_zo*(delta_z+g));
zeo     = s_s*zo;
remito  = share_remit*yo;
grantso = share_grants*yo;
dploto  = d_o;
nug     = r_dco-rstar;
nu      = ro-r_dco;

%% IMPLICIT PARAMETERS AND SOME INITIAL VALUES
%% Solving for VA_n, eo, eho, To, and psi_x

xn0 = [0.5 77 80 8 0.5 0.5]';

% Use Broyden Method to Solve the System of Equations

x = broyden('calibration',xn0,VA_n,imp2gdp,a_k,delta_x,g,alpha_x,r_xo,yo,delta_n,alpha_n,r_no,a_z,delta_z,P_ko,P_zo,d_o,dco,r_dco,bstaro,rstar,R_zo,zo,remito,grantso,oilro,wo,nxpsi,a_ratio,ho,bo,ro,miu,zeo,s_s,nu,nug);

x = real(x);

[f, xcal] = calibration(x,VA_n,imp2gdp,a_k,delta_x,g,alpha_x,r_xo,yo,delta_n,alpha_n,r_no,a_z,delta_z,P_ko,P_zo,d_o,dco,r_dco,bstaro,rstar,R_zo,zo,remito,grantso,oilro,wo,nxpsi,a_ratio,ho,bo,ro,miu,zeo,s_s,nu,nug);

gama_n = xcal(1);
eo     = xcal(2);
eho    = xcal(3);
To     = xcal(4);
psi_x  = xcal(5);
gama_m = xcal(6);


%% Using gama_n, gama_m, eo, eho, To, and psi_x to calculate the rest of parameters and initial values

gama_x  = 1-gama_n-gama_m;
rho_x   = gama_x;
rho_m   = gama_m;
psi_n   = nxpsi*psi_x;
q_no    = VA_n*yo;
q_xo    = (1-VA_n)*yo;
k_no    = (alpha_n/r_no)*q_no;
k_xo    = (alpha_x/r_xo)*q_xo;
L_no    = ((1-alpha_n)/wo)*q_no;
L_xo    = ((1-alpha_x)/wo)*q_xo;
Lo      = (L_no+L_xo)/(1+a_ratio);
Lho     = a_ratio*Lo;
a_n     = q_no/(zeo^psi_n*k_no^(xi_n+alpha_n)*L_no^(1-alpha_n));
a_x     = q_xo/(zeo^psi_x*k_xo^(xi_x+alpha_x)*L_xo^(1-alpha_x));
i_zo    = (delta_z+g)*zo;

save params.mat itermax beta beta_t yo bo bstaro d_o dco P_no P_xo P_mo P_mmo Po wo P_ko P_zo a_k a_z ro r_xo r_no miu nu_x nu_n zo zeo remito grantso dploto nug nu gama_n eo eho To psi_x gama_m gama_x rho_x rho_m psi_n q_no q_xo k_no k_xo L_no L_xo Lo Lho a_n a_x i_zo -append
