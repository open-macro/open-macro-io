// declare endogenous variables
var c k s invk invs d f r ca tb ynon y vv gov AC_s AC_k  govh yoil ch T A; 

// declare exogenous variables
varexo e_yoil0 e_yoil1 e_yoil2 e_yoil0_neg e_yoil1_neg e_yoil2_neg
       e_T0    e_T1    e_T2    e_T0_neg    e_T1_neg    e_T2_neg 
       e_Abar0 e_Abar1 e_Abar2 e_Abar0_neg e_Abar1_neg e_Abar2_neg;

// parameters
parameters theta_k theta_s gamma delta_k delta_s beta kappa e_k e_s phi_k
	      phi_s rbar psi rho1 rho2 rho3 omega dbar g_n g_a g xi Abar 
	         yoil_0 f_0 r_0 d_0 invk_0 invs_0 k_0 s_0 c_0 ca_0 gov_0 T_0 itermax;

load params.mat;   
for i=1:length(M_.params)
    parameter_name = M_.param_names(i,:);
    eval(['M_.params(i)  = ' parameter_name ' ;']);
end;   

model;

// 0. technology (A)
A = Abar + e_Abar0 + e_Abar1 - e_Abar0_neg - e_Abar1_neg;

// 1. FOC to d(t)
0 = (c^(-gamma)-beta*(1+g)*xi*c(+1)^(-gamma)) - beta*(c(+1)^(-gamma)-beta*(1+g)*xi*c(+2)^(-gamma))*(1+r+d*(psi/(rho1^2))*(rho1*exp(rho1*(d-dbar-omega*vv))-rho2)); 

// 2. FOC to k(t)
0 = -(c^(-gamma)-beta*(1+g)*xi*c(+1)^(-gamma))/e_k + beta*((c(+1)^(-gamma)-beta*(1+g)*xi*c(+2)^(-gamma))/e_k)*(1-delta_k) + beta*(c(+1)^(-gamma)-beta*(1+g)*xi*c(+2)^(-gamma))*(A)*theta_k*k^(theta_k-1)*s^(theta_s) - (1/(1+g))*(c^(-gamma)-beta*(1+g)*xi*c(+1)^(-gamma))*phi_k*(k/k(-1)-1) - beta*(c(+1)^(-gamma)-beta*(1+g)*xi*c(+2)^(-gamma))*(phi_k/2)*(k(+1)/k-1)^2 + beta*(c(+1)^(-gamma)-beta*(1+g)*xi*c(+2)^(-gamma))*phi_k*(k(+1)/k-1)*(k(+1)/k);

// 3. FOC to s(t)
0 = -(c^(-gamma)-beta*(1+g)*xi*c(+1)^(-gamma))/e_s + beta*((c(+1)^(-gamma)-beta*(1+g)*xi*c(+2)^(-gamma))/e_s)*(1-delta_s) + beta*(c(+1)^(-gamma)-beta*(1+g)*xi*c(+2)^(-gamma))*(A)*theta_s*s^(theta_s-1)*k^(theta_k) - (1/(1+g))*(c^(-gamma)-beta*(1+g)*xi*c(+1)^(-gamma))*phi_s*(s/s(-1)-1) - beta*(c(+1)^(-gamma)-beta*(1+g)*xi*c(+2)^(-gamma))*(phi_s/2)*(s(+1)/s-1)^2 + beta*(c(+1)^(-gamma)-beta*(1+g)*xi*c(+2)^(-gamma))*phi_s*(s(+1)/s-1)*(s(+1)/s);

// 4. BC 
0 = yoil + ynon + d*(1+g)-(1+r(-1))*d(-1)-ch - invk - invs - govh - AC_s - AC_k + T;

// 5. production 
0 = ynon - (A)*(k(-1)^(theta_k))*(s(-1)^(theta_s)) ;

// 6. private investment 
0 = k*(1+g)-(1-delta_k)*k(-1)-e_k*invk;

// 7. public investment 
0 = s*(1+g)-(1-delta_s)*s(-1)-e_s*invs;

// 8. interest rate 
r= rbar+(psi/(rho1^2))*(exp(rho1*(d-dbar-omega*vv))-rho2*(d-dbar-omega*vv)-rho3);

// 8. tb
0= y-ch-invk-invs-govh-AC_k-AC_s-tb;

// 10. foreign asset position
0 = f+d; 

// 11. ca
ca = tb+T-r(-1)*d(-1);

// 12. total GDP
0 = y -yoil -ynon;

//13. NPV of oil
0 = yoil + vv(+1)*(1+g)/(1+rbar) - vv;

//14. Adjustment costs on k
AC_k = (phi_k/2)*(k/k(-1)-1)^2*k(-1);

// 15. Adjustment costs on s
AC_s = (phi_s/2)*(s/s(-1)-1)^2*s(-1);

// 16. Government expenditure
0 = (c^(-gamma)-beta*(1+g)*xi*c(+1)^(-gamma)) - kappa*(gov^(-gamma)-beta*(1+g)*xi*gov(+1)^(-gamma)) ;

// 17. Habit private consumption
0 = c-(ch-xi*ch(-1));

// 18. Habit public consumption
0 = gov-(govh-xi*govh(-1));

// 19. oil
yoil = yoil_0 + y * (e_yoil0 + e_yoil1 - e_yoil0_neg - e_yoil1_neg);

// 20. Adjustment Variable (Transfers)
T = T_0 + y * (e_T0 + e_T1 - e_T0_neg - e_T1_neg);	  

end;  

// steady state (analytical solved)
options_.simul.maxit = itermax;

initval;
s    = s_0;
k    = k_0;
ynon = Abar*(k^(theta_k))*(s^(theta_s));
yoil = yoil_0;
y    = ynon + yoil;
f    = f_0*y;
r    = r_0;
invk = 0.8*invk_0*y;
invs = 0.8*invs_0*y;
vv   = vvvalue;
AC_k = 0.2*invk_0*y;
AC_s = 0.2*invs_0*y;
ca   = ca_0*y;
d    = d_0*y_0; 
govh = gov_0*y;
gov  = (1-xi)*govh;
ch   = c_0*y;
c    = (1-xi)*ch;
T    = T_0*y;
tb   = ca+r*d-T;
A    = Abar;
end;

@#include "ca_shocks.mod"

// simulate model deterministically
options_.debug=1;
simul(periods=1000); 