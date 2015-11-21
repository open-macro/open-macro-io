yo      = 100; 
m       = 1;
beta    = ((1+g)^(1/tau))/(1+ro);
beta_t  = (beta*(1+g)^(1-1/tau));
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
nug     = r_dco-r_f;
nu      = ro-r_dco;

xn0       = [0.5 77 80 8 0.5 0.5]';
x         = broyden('calibration',xn0,VA_n,imp2gdp,a_k,delta_x,g,alpha_x,r_xo,yo,delta_n,alpha_n,r_no,a_z,delta_z,P_ko,P_zo,d_o,m,dco,r_dco,bstaro,r_f,R_zo,zo,remito,grantso,oilro,wo,nxpsi,a_ratio,ho,bo,ro,miu,zeo,s_s,nu,nug);
x         = real(x);
[f, xcal] = calibration(x,VA_n,imp2gdp,a_k,delta_x,g,alpha_x,r_xo,yo,delta_n,alpha_n,r_no,a_z,delta_z,P_ko,P_zo,d_o,m,dco,r_dco,bstaro,r_f,R_zo,zo,remito,grantso,oilro,wo,nxpsi,a_ratio,ho,bo,ro,miu,zeo,s_s,nu,nug);

gama_n = xcal(1);
eo     = xcal(2);
eho    = xcal(3);
To     = xcal(4);
psi_x  = xcal(5);
gama_m = xcal(6);

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

save dsa_params.mat beta beta_t delta_x delta_n delta_z alpha_k alpha_z ...
    tau psi_x psi_n xi_n xi_x omega alpha_x alpha_n g epsilon gama_n ...
    gama_x gama_m m eta rho_x rho_m R_zo yo phi ho r_f ...
    share_bstar share_b share_d fo s a_k a_z miu nu_x nu_n VA_n ro To ...
    d_o bo zo P_zo Lho a_n a_x m r_dco dco lambda lambda1 lambda2 ...
    lambda3 lambda4 eo eho s_s a_ratio izy nxpsi share_remit  ...
    share_grants remito  grantso i_zo Lo zeo sigma_x sigma_n nu q_xo ...
    q_no bstaro etag nug imp2gdp;
