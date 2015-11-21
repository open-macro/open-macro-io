% solve the steady states analytically
% 
% with adjustment costs and interest rates with risk premium
%
% The interest rate is internalized
% and 
% The interest rate has a wedge when there is a positive debt
        
% this changes the determination of the steady-state debt and interest rate
dvalue = dbar;
fvalue = - dvalue; 
rvalue = rbar + (psi/(rho1^2))*(1-rho3);
ikk_ratio = (g_n+g_a+delta_k)/e_k;
iss_ratio = (g_n+g_a+delta_s)/e_s;
lamdaetak_ratio = e_k;
lamdaetas_ratio = e_s;
temp_k = ((1-beta*(1-delta_k))/(lamdaetak_ratio*beta*Abar*theta_k));
temp_s = ((1-beta*(1-delta_s))/(lamdaetas_ratio*beta*Abar*theta_s));
ks_ratio = temp_s/temp_k;
svalue = (temp_k/(ks_ratio)^(theta_k-1))^(1/(theta_k+theta_s-1));
kvalue = svalue*ks_ratio;
ikvalue = kvalue*ikk_ratio;
isvalue = svalue*iss_ratio;
ynonvalue = Abar*(kvalue^theta_k)*(svalue^theta_s);
yvalue = ynonvalue + yoilvalue;
chvalue = ((g_n+g_a-rvalue)*dbar + yoilvalue + ynonvalue + T_0 - ikvalue -isvalue)/(1+kappa^(1/gamma));
govhvalue = kappa^(1/gamma)*chvalue;
cvalue = (1-xi)*chvalue;
govvalue = (1-xi)*govhvalue; 
tbvalue = yoilvalue + ynonvalue - ikvalue -isvalue - chvalue-govhvalue; 
cavalue = (g_n+g_a)*fvalue;
vvvalue = yoilvalue*(1/(1-(1+g_n+g_a)/(1+rbar)));
