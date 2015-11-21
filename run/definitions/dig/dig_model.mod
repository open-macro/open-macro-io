// ----------------------------------------------------------------------------
// Debt Investment Growth Model based on Buffie et al. (2012)
// ----------------------------------------------------------------------------

// Endogenous variables -------------------------------------------------------
var b bstar d dc dplot e eh GAP grants growth_plot h in ix iz kn kx L_n L_x 
    netbwconc oilr p pk pm pmm pn px pz qn qx r r_d remit rer rext rextg rn rx
    Rz T tot totmm w ynom z ze;

// Exogenous variables --------------------------------------------------------
varexo e_iz0     e_iz1     e_iz2     e_iz0_neg     e_iz1_neg     e_iz2_neg
       e_d0      e_d1      e_d2      e_d0_neg      e_d1_neg      e_d2_neg
       e_b0      e_b1      e_b2      e_b0_neg      e_b1_neg      e_b2_neg
       e_dc0     e_dc1     e_dc2     e_dc0_neg     e_dc1_neg     e_dc2_neg
       e_grants0 e_grants1 e_grants2 e_grants0_neg e_grants1_neg e_grants2_neg
       e_oilr0   e_oilr1   e_oilr2   e_oilr0_neg   e_oilr1_neg   e_oilr2_neg		       
       e_remit0  e_remit1  e_remit2  e_remit0_neg  e_remit1_neg  e_remit2_neg
       e_hbar0   e_hbar1   e_hbar2   e_hbar0_neg   e_hbar1_neg   e_hbar2_neg
       e_Tbar0   e_Tbar1   e_Tbar2   e_Tbar0_neg   e_Tbar1_neg   e_Tbar2_neg
       e_px0     e_px1     e_px2     e_px0_neg     e_px1_neg     e_px2_neg
       e_pm0     e_pm1     e_pm2     e_pm0_neg     e_pm1_neg     e_pm2_neg
       e_pmm0    e_pmm1    e_pmm2    e_pmm0_neg    e_pmm1_neg    e_pmm2_neg
       e_intpay0 e_intpay1 e_intpay2 e_intpay0_neg e_intpay1_neg e_intpay2_neg;

// Parameters -----------------------------------------------------------------
parameters a_k a_n a_ratio a_x a_z alpha_k alpha_n alpha_x alpha_z beta beta_t
	         bo bstaro d_o dco delta_n delta_x delta_z eho eo epsilon eta etag 
	         fo g gama_m gama_n gama_x grantso ho lambda lambda1 lambda2 lambda3 
		       lambda4 Lo miu nu nu_n nu_x nug oilro omega P_zo phi psi_n psi_x 
		       q_no q_xo r_dco R_zo remito rho_m rho_x ro rstar s s_s share_b 
		       share_bstar share_d sigma_n sigma_x tau To VA_n xi_n xi_x yo zeo zo itermax;
         
load params.mat;          

for i=1:length(M_.params)
    deep_parameter_name = M_.param_names(i,:);
    eval(['M_.params(i)  = ' deep_parameter_name ' ;'])
end   

// Model equations ------------------------------------------------------------
model;

// capital adjustment costs
#Robx =(nu_x/2)*kx(-1)*((ix/kx(-1)) - delta_x - g)^2; 
#Robn =(nu_n/2)*kn(-1)*((in/kn(-1)) - delta_n - g)^2;

// analogue of (1-rho_x-rho_m)*(pn/p)^(-epsilon)  
#compn = (1-rho_x-rho_m)*pn^(-epsilon)/(rho_m*pm^(1-epsilon)+rho_x*px^(1-epsilon)+(1-rho_x-rho_m)*pn^(1-epsilon));

// absorptive capacity constraint
#Jimz =(((1+iz/z(-1) - delta_z - g)^phi)*(iz - (delta_z+g)*zo) + (delta_z+g)*zo)/iz; 

// Cobb-Douglas technologies of the firms in each sector
qx = a_x*(qx/q_xo)^sigma_x*(ze(-1)^psi_x)*(kx(-1)^(xi_x + alpha_x))*(L_x^(1 - alpha_x));
qn = a_n*(qn/q_no)^sigma_n*(ze(-1)^psi_n)*(kn(-1)^(xi_n + alpha_n))*(L_n^(1 - alpha_n));

// supply prices of private and public capital
pk = pmm + a_k*pn;
pz = pmm + a_z*pn;

// CPI associated with CES consumption basket
p = (rho_m*pm^(1-epsilon) + rho_x*px^(1-epsilon) + (1-rho_m-rho_x)*pn^(1-epsilon))^(1/(1-epsilon));

// first-order conditions of the consumers maximization problem
((e(+1)/p(+1))/(e/p))^(1/tau) = beta_t*(1+h)*(1+r)/((1+h(+1))*(1+g));
(1+r)*(p(+1)/p)*(pk/pk(+1))*(1 + nu_x*((ix/kx(-1))-delta_x-g)) = (rx(+1)/pk(+1)) + (1-delta_x) + nu_x*((ix(+1)/kx)-delta_x-g)*((ix(+1)/kx)+1-delta_x) - (nu_x/2)*(((ix(+1)/kx)-delta_x-g)^2);
(1+r)*(p(+1)/p)*(pk/pk(+1))*(1 + nu_n*((in/kn(-1))-delta_n-g)) = (rn(+1)/pk(+1)) + (1-delta_n) + nu_n*((in(+1)/kn)-delta_n-g)*((in(+1)/kn)+1-delta_n) - (nu_n/2)*(((in(+1)/kn)-delta_n-g)^2);
1+rext=(1-eta*(bstar-bstaro))*(1+r)*p(+1)/p;

// law of motion of private capital in each sector
(1+g)*kx = ix + (1-delta_x)*kx(-1);
(1+g)*kn = in + (1-delta_n)*kn(-1);

// law of motion of public capital
(1+g)*z = iz + (1-delta_z)*z(-1);
ze = s_s*zo + s*(z-zo);

// marginal product of capital and labor in each sector 
// note: wage is equal across sectors by design
pn*(1-alpha_n)*qn/L_n = w;
px*(1-alpha_x)*qx/L_x = w;
pn*alpha_n*qn/kn(-1) = rn;
px*alpha_x*qx/kx(-1) = rx;

// market clearing condition for non-traded goods
qn = compn*(e+eh) + a_k*(ix+in+Robx+Robn) + a_z*Jimz*iz;
L_x + L_n = (1+a_ratio)*Lo;

// market clearing acounting identity
d + dc + bstar = (e+eh) + pk*(ix+in+Robx+Robn) + pz*Jimz*iz + (1+r_d)*d(-1)/(1+g)+ (1+rextg(-1))*dc(-1)/(1+g) + (1+rext(-1))*bstar(-1)/(1+g) + (eta/2)*(bstar-bstaro)^2 - (pn*qn) - (px*qx) - (grants+oilr) - remit;

// non-savers budget constraint
eh = (a_ratio*w*Lo+(a_ratio/(1+a_ratio))*(T+remit))/(1+h);

// gross return on infrastructure 
// note: pn*qn=VA_n
Rz = (psi_n*pn*qn+psi_x*px*qx)/(pz*ze(-1));

// real interest rates
// |rextg| - in paper named |r_dc|
// |rstar| - in paper named |r_f|
// |rext|  - in paper named |r*|
// |nu|    - public debt risk premium
rextg = rstar+nug*exp(etag*(d/ynom+dc/ynom-d_o/yo-dco/yo));
rext = rextg+nu;

// Nominal GDP
ynom = pn*qn + px*qx;
growth_plot = (qn-qn(-1))/qn(-1) + (qx-qx(-1))/qx(-1) + g; % growth_plot is created just to plot the path of actual GDP growth

// fiscal GAP and adjustment via transfers (T) and taxes (h) 
// note: e+eh = p*c
#DD = ((1+r_d)*d(-1)/(1+g) - d) + ((1+rextg(-1))*dc(-1)/(1+g) - dc) + ((1+r(-1))*p*b(-1)/(1+g) - p*b) + (pz*Jimz*iz) + To - ho*(e+eh) - (grants+oilr) - miu*ze(-1);
#DDo = (r_d-g)*d_o/(1+g) + (rstar+nug-g)*dco/(1+g) + (ro-g)*bo/(1+g) + P_zo*(delta_z+g)*zo + To - ho*(eo+eho) - (grantso+oilro) - miu*zeo;

// defining the targets (h_target and T_target)
// NOTE: changed so that there is no way to change dc_target (reverts to dco) 
#h_target = ho + (1-lambda)*GAP/(e+eh);
#T_target = To - lambda*GAP;
#T1 = T(-1) + lambda3*(T_target-T(-1)) - lambda4*(dc(-1)-dco);
#h1 = h(-1) + lambda1*(h_target-h(-1)) + lambda2*(dc(-1)-dco)/(pn*qn + px*qx);

// fiscal gap
@#if exogenous
   // (i) uncostrained fiscal adjustment (i.e. concessional debt only)
   GAP = DD - DDo;
@#else
   // (ii) costrained fiscal adjustment (i.e. endogenous borrowing only)
   (h-ho)*(e+eh) - (T-To) = DD;
   GAP = (dc-dc(-1)) + (p*b-p*b(-1)) + (h-ho)*(e+eh) - (T-To);
@#endif
// @#if exogenous
//    // (i) uncostrained fiscal adjustment (i.e. concessional debt only)
//    GAP = DD - DDo;
// @#else
//    // (ii) costrained fiscal adjustment (i.e. endogenous borrowing only)
//    (h-ho)*(e+eh) - (T-To) = DD;
//    GAP = (dc-dc(-1)) + (p*b-p*b(-1)) + (h-ho)*(e+eh) - (T-To);
// @#endif

// transfers and taxes at the target level
@#if exogenous
   T = T_target;
   h = h_target;
@#endif

// exogenous ceiling path for taxes
// EXOVAR (hbar) 
#hbar_staggered = ho + e_hbar0 + e_hbar1 + e_hbar2 - e_hbar0_neg - e_hbar1_neg - e_hbar2_neg;
@#if endogenous_commercial || endogenous_domestic
     h = min(h1,hbar_staggered);
@#endif

// exogenous floor path for transfers
// EXOVAR (Tbar)
#Tbar_staggered = To + e_Tbar0 + e_Tbar1 + e_Tbar2 - e_Tbar0_neg - e_Tbar1_neg - e_Tbar2_neg;
@#if endogenous_commercial || endogenous_domestic
     T = max(T1,Tbar_staggered);
@#endif

// GDP adjustor
#uazuaz = yo/ynom;

// exogenous domestic borrowing 
// fiscal adjustment is unconstrained or comes from external commercial debt
@#if exogenous
     b = e_b0/uazuaz + e_b1/uazuaz + e_b2/uazuaz - e_b0_neg/uazuaz - e_b1_neg/uazuaz - e_b2_neg/uazuaz + bo;
@#endif
@#if endogenous_commercial
     b = bo;
@#endif

// exogenous concessional borrowing
// EXOVAR (d)
d = d_o*g/(1+g) + d(-1)/(1+g) + e_d0/uazuaz + e_d1/uazuaz + e_d2/uazuaz - e_d0_neg/uazuaz - e_d1_neg/uazuaz - e_d2_neg/uazuaz;
netbwconc = e_d0 + e_d1 + e_d2 - e_d0_neg - e_d1_neg - e_d2_neg;

// dplot is created to plot the path of actual d, not deflated by trend growth
dplot = e_d0 + e_d1 + e_d2 - e_d0_neg - e_d1_neg - e_d2_neg + dplot(-1);

// exogenous commercial borrowing 
// (fiscal adjustment is unconstrained or comes from internal public debt)
// EXOVAR (dc)
@#if exogenous
   dc = e_dc0/uazuaz + e_dc1/uazuaz + e_dc2/uazuaz - e_dc0_neg/uazuaz - e_dc1_neg/uazuaz - e_dc2_neg/uazuaz + dc(-1)/(1+g);
@#endif
@#if endogenous_domestic
   dc = dco;
@#endif

// exogenous public investment
// EXOVAR (iz)
#uaz = pz/P_zo*yo/ynom;
iz*uaz = (delta_z+g)*zo + e_iz0 + e_iz1 + e_iz2 - e_iz0_neg - e_iz1_neg - e_iz2_neg;

// exogenous grants, oil revenues, remittances
// EXOVAR: grants
// EXOVAR: oilr
// EXOVAR: remit
grants*uazuaz = grantso + e_grants0 + e_grants1 + e_grants2 - e_grants0_neg - e_grants1_neg - e_grants2_neg;
oilr*uazuaz = oilro + e_oilr0 + e_oilr1 + e_oilr2 - e_oilr0_neg - e_oilr1_neg - e_oilr2_neg;
remit*uazuaz = remito + e_remit0 + e_remit1 + e_remit2 - e_remit0_neg - e_remit1_neg - e_remit2_neg;

// interest repayment on concessional debt
#foo = d(-1)/(1+g);
#int_repayment = e_intpay0 + e_intpay1 + e_intpay2 - e_intpay0_neg - e_intpay1_neg - e_intpay2_neg;
r_d*foo = int_repayment/uazuaz;

// exogenous price paths
px = 1 + e_px0 + e_px1 + e_px2 - e_px0_neg - e_px1_neg - e_px2_neg;
pm = 1 + e_pm0 + e_pm1 + e_pm2 - e_pm0_neg - e_pm1_neg - e_pm2_neg;
pmm = 1 + e_pmm0 + e_pmm1 + e_pmm2 - e_pmm0_neg - e_pmm1_neg - e_pmm2_neg;

// real exchange rate
rer = pn/px;

// terms of trade
tot = px/pm;
totmm = px/pmm;

end;

// Load and assign initial values ---------------------------------------------
load steady_state_values.mat;

options_.simul.maxit = itermax;

initval;
T           = T_ini;
qx          = q_x_ini;
qn          = q_n_ini;
kx          = k_x_ini;
kn          = k_n_ini;
L_x         = L_x_ini;
L_n         = L_n_ini;
z           = z_ini;
ze          = ze_ini;
pk          = P_k_ini;
pz          = P_z_ini;
e           = e_ini;
eh          = eh_ini;
w           = w_ini;
pn          = P_n_ini;
p           = P_ini;
ix          = i_x_ini;
in          = i_n_ini;
h           = h_ini;
rx          = r_x_ini;
rn          = r_n_ini;
iz          = i_z_ini;
r           = r_ini;
bstar       = bstar_ini;
Rz          = R_z_ini;
b           = bo;
d           = d_o;
dc          = dco;
dplot       = d_o;
e_dc0       = dco*g/(1+g);
remit       = remito;
grants      = grantso;
oilr        = oilro;
ynom        = yo;
growth_plot = g;
netbwconc   = 0;
rextg       = rstar+nug;
rext        = rextg+nu;
px          = 1;
pm          = 1;
pmm         = 1;
rer         = P_n_ini/px;
tot         = px/pm;
totmm       = px/pmm;
r_d         = 0;
GAP         = 0;
end;

// Solve for steady state -----------------------------------------------------
steady;