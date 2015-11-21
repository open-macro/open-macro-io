
function [f, xout] = steady_state(x,beta_t,delta_x,delta_n,delta_z,tau,psi_x,psi_n,xi_n,xi_x,alpha_x,alpha_n,g,epsilon,eta,ho,rstar,s,rho_x,rho_m,a_k,a_z,miu,ro,To,d_o,bo,zo,P_zo,P_x,P_mm,P_m,a_n,a_x,inc,m,r_dco,incdc,dco,incb,inciz,lambda,eo,eho,s_s,a_ratio,remito,grantso,oilro,i_zo,Lo,incgrants,incremit,sigma_x,sigma_n,nu,bstaro,q_no,q_xo,yo,etag,nug)


f = zeros(length(x),1);

b = incb*bo;
d = inc*d_o;
dc = incdc*dco;
i_z =i_zo+inciz;
grants =incgrants*grantso;
oilr = oilro;
remit =incremit*remito;
r_do = 0;

DDo = (r_do-g)*d_o/(1+g) + (ro-g)*bo/(1+g) + (rstar+nug-g)*m*dco/(1+g) + P_zo*i_zo-miu*s_s*zo-(grantso + oilro);

bstar = x(1);
c = x(2);
c_n = x(3);
e = x(4);
eh = x(5);
h = x(6);
i_n = x(7);
i_x = x(8);
k_n = x(9);
k_x = x(10);
L_n = x(11);
L_x = x(12);
P = x(13);
P_k = x(14);
P_n = x(15);
P_z = x(16);
r = x(17);
r_n = x(18);
r_x = x(19);
T = x(20);
q_n = x(21);
q_x = x(22);
w = x(23);
y = x(24);
z = x(25);
ze = x(26);




f(1) = 1 + r - (1+rstar+nu+nug*exp(etag*(d/y+m*dc/y-d_o/yo-m*dco/yo)))/(1-eta*(bstar-bstaro));
f(2) = bstar + d + m*dc - P*c - P_k*(i_x+i_n) - P_z*i_z - (1+r_do)*d/(1+g) - (1+rstar+nug*exp(etag*(d/y+m*dc/y-d_o/yo-m*dco/yo)))*m*dc/(1+g) - (1+rstar+nu+nug*exp(etag*(d/y+m*dc/y-d_o/yo-m*dco/yo)))*bstar/(1+g) + y + remit + (grants+oilr);
f(3) = c_n - (1-rho_x-rho_m)*P_n^(-epsilon)*(e+eh)/(rho_m*P_m^(1-epsilon)+rho_x*P_x^(1-epsilon)+(1-rho_x-rho_m)*P_n^(1-epsilon));
f(4) = e + eh - P*c;
f(5) = (1+h)*eh - a_ratio*w*Lo - (a_ratio/(1+a_ratio))*(T+remit);
f(6) = h*(e+eh) - ho*(eo+eho) - ((r_do-g)*d/(1+g) + (r-g)*P*b/(1+g) + (rstar+nug*exp(etag*(d/y+m*dc/y-d_o/yo-m*dco/yo))-g)*m*dc/(1+g) + P_z*i_z + T-To - miu*ze - (grants+oilr) - DDo);
f(7) = T-To + lambda*((r_do-g)*d/(1+g) + (r-g)*P*b/(1+g) + (rstar+nug*exp(etag*(d/y+m*dc/y-d_o/yo-m*dco/yo))-g)*m*dc/(1+g) +  P_z*i_z+ho*(e+eh-eo-eho)-miu*ze-(grants + oilr)-DDo);  
f(8) = i_n - (delta_n+g)*k_n;
f(9) = i_x - (delta_x+g)*k_x;
f(10) = z - i_z/(delta_z+g);
f(11) = (1+a_ratio)*Lo-L_x-L_n;
f(12) = r_n - alpha_n*P_n*q_n/k_n;
f(13) = r_x - alpha_x*P_x*q_x/k_x;
f(14) = q_n - a_n*(q_n/q_no)^sigma_n*k_n^(xi_n+alpha_n)*ze^psi_n*L_n^(1-alpha_n);
f(15) = P - (rho_m*P_m^(1-epsilon)+rho_x*P_x^(1-epsilon)+(1-rho_x-rho_m)*P_n^(1-epsilon))^(1/(1-epsilon));
f(16) = P_k - P_mm - a_k*P_n;
f(17) = w - P_n*(1-alpha_n)*q_n/L_n;
f(18) = P_z - P_mm - a_z*P_n;
f(19) = r - (1/beta_t)*(1+g) + 1;
f(20) = r_n - P_k*(delta_n+r);
f(21) = r_x - P_k*(delta_x+r);
f(22) = q_n - c_n - a_k*(i_x+i_n) - a_z*i_z;
f(23) = q_x - a_x*(q_x/q_xo)^sigma_x*k_x^(xi_x+alpha_x)*ze^psi_x*L_x^(1-alpha_x);
f(24) = w - P_x*(1-alpha_x)*q_x/L_x;
f(25) = y - P_n*q_n - P_x*q_x;
f(26) = ze - s_s*zo - s*(z-zo);



xout = [ bstar; c; c_n; e; eh; h; i_n; i_x; k_n; k_x; L_n; L_x; P; P_k; P_n; P_z; r; r_n; r_x; T; q_n; q_x; w; y; z; ze];
