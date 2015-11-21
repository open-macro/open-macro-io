# set explicit parameters

VA_n         = 0.49; %- Value added in NT-sector
imp2gdp      = 44; %- Imports to GDP ratio 
ro           = 0.1; %- Initial RIR on dom. debt
ho           = 0.15; %- Initial consumption VAT
share_bstar  = 0; %- Initial pvt. external debt to GDP ratio
share_b      = 0.2; %- Initial public domestic debt to GDP ratio
share_d      = 0.5; %- Initial public concessional debt to GDP ratio
share_dc     = 0; %- Initial public external commercial debt to GDP ratio
share_remit  = 0.04; %- Remittances to GDP ratio
share_grants = 0.05; %- Grants to GDP ratio
r_dco        = 0.060; %- Initial RIR on public commercial loans
izy          = 0.06; %- Initial ratio of infrastructure investment to GDP
a_ratio      = 1.5; %- NS/S - Labor ratio of Non-Savers(NS) to Savers(S)
alpha_x      = 0.40; %- Capital's share in value added in the T-sector
alpha_n      = 0.55; %- Capital's share in value added in the NT-sector
eta          = 1.0; %- Portfolio adjustment costs parameter
fo           = 0.5; %- User fees for infrastructure services
R_zo = 0.3; %- Initial return on infrastructure
s    = 0.6; %- Efficiency of public investment
s_s  = 0.6; %- Sstate eff. of public investment
g    = 0.015; %- Trend per capita growth rate
tau     = 0.34; %- INTERtemporal elasticity of substitution
alpha_k = 0.5; %- Cost share of NT-inputs in the production of private capital
alpha_z = 0.5; %- Cost share of NT-inputs in the production of public capital
delta_x = 0.05; %- Depreciation rate in T-sector
delta_n = 0.05; %- Depreciation rate in NT-sector
delta_z = 0.05; %- Depreciation rate of public capital
xi_x    = 0.0; %- Capital learning externalities in T-sector
xi_n    = 0.0; %- Capital learning externalities in NT-sector
sigma_x = 0; %- Traded T-sector output learning externality
sigma_n = 0; %- Non-traded NT-sector output learning externality
omega   = 2; %- Tobin's q-elasticity of investment spending
epsilon = 0.5; %- INTRAtemporal elasticity of substitution across goods
etag    = 0; %- Public debt risk premium
phi     = 0; %- Determines the severity of absorptive capacity constraint 
rstar   = 0.04; %- Risk-free foreign RIR (r^f)
oilro   = 0; %- Initial oil revenues -- not a parameter in Felipe's file
lambda  = 0; %- Division of fiscal adjustment parameter (=0 all taxes)
lambda1 = 0.25; %.217; %- Fiscal reaction parameter (policy instrument terms)
lambda2 = 0.02; %.02; %- Fiscal reaction parameter (debt terms)
lambda3 = 0.25; %- Fiscal reaction parameter (policy instrument terms)
lambda4 = 0.02; %0.04;%.04; %- Fiscal reaction parameter (debt terms)
nxpsi   = 1; 

save params.mat VA_n imp2gdp ro ho share_bstar share_b share_d share_dc ...
     share_remit share_grants r_dco izy a_ratio alpha_x alpha_n eta fo R_zo ...
     s s_s g tau alpha_k alpha_z delta_x delta_n delta_z xi_x xi_n sigma_x ...
     sigma_n omega epsilon etag phi rstar oilro lambda lambda1 lambda2 ...
     lambda3 lambda4 nxpsi;
