%%%%% System of Equations for Calibration
%%%%% April 23, 2010


function [f, xout] = calibration(x,VA_n,imp2gdp,a_k,delta_x,g,alpha_x,r_xo,yo,delta_n,alpha_n,r_no,a_z,delta_z,P_ko,P_zo,d_o,dco,r_dco,bstaro,rstar,R_zo,zo,remito,grantso,oilro,wo,nxpsi,a_ratio,ho,bo,ro,miu,zeo,s_s,nu,nug)

f = zeros(length(x),1);

r_do = 0;

gama_n = x(1);
e      = x(2);
eh     = x(3);
T      = x(4);
psi_x  = x(5);
gama_m = x(6);

f(1) = gama_n*(e+eh) + a_k*((delta_x+g)*((alpha_x/r_xo)*(1-VA_n)*yo) + (delta_n+g)*((alpha_n/r_no)*VA_n*yo)) + a_z*(delta_z+g)*zo - VA_n*yo;
f(2) = e+eh + P_ko*((delta_x+g)*((alpha_x/r_xo)*(1-VA_n)*yo)+(delta_n+g)*((alpha_n/r_no)*VA_n*yo)) + P_zo*(delta_z+g)*zo + d_o*(1+r_do)/(1+g) + dco*(1+rstar+nug)/(1+g) + bstaro*(1+rstar+nu+nug)/(1+g) - yo - bstaro - d_o - dco - remito - (grantso+oilro);
f(3) = (1+ho)*eh - wo*(a_ratio/(1+a_ratio))*((1-alpha_x)*(1-VA_n)*yo+(1-alpha_n)*VA_n*yo) - (a_ratio/(1+a_ratio))*(remito+T);
f(4) = bo + d_o + dco - P_zo*(delta_z+g)*zo - bo*(1+ro)/(1+g) - d_o*(1+r_do)/(1+g) - dco*(1+rstar+nug)/(1+g) + ho*(e+eh) + miu*zeo + (grantso+oilro) - T;
f(5) = zo*s_s - (nxpsi*psi_x*VA_n+psi_x*(1-VA_n))*yo/(R_zo*P_zo);
f(6) = gama_m*(e+eh) + (delta_x+g)*(alpha_x/r_xo)*(1-VA_n)*yo + (delta_n+g)*(alpha_n/r_no)*VA_n*yo + (delta_z+g)*zo - imp2gdp;


xout = [gama_n; e; eh; T; psi_x; gama_m];

