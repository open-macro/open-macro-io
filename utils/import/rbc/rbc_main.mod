var y I k c R w n a g tau z Iz;

varexo e_a0 e_a1 e_a2 e_a0_neg e_a1_neg e_a2_neg
	   e_g0 e_g1 e_g2 e_g0_neg e_g1_neg e_g2_neg
	   e_z0 e_z1 e_z2 e_z0_neg e_z1_neg e_z2_neg;

parameters alpha beta delta rho rho_g g_bar rho_z Iz_bar xi itermax;
load params.mat;   
for i=1:length(M_.params)
    parameter_name = M_.param_names(i,:);
    eval(['M_.params(i)  = ' parameter_name ' ;']);
end;

model;
1/c  = beta * (1/c(+1)) * (R(+1)+(1-delta));
y = a * z^(xi) * k(-1)^alpha * n^(1-alpha);
k = I + (1-delta) * k(-1);
y = c + I + Iz;
n = 1;
R = alpha*y/k(-1);
w = (1-alpha)*y/n;
log(a) = rho*log(a(-1)) + e_a0 + e_a1 + e_a2 - e_a0_neg - e_a1_neg - e_a2_neg;
g + Iz = tau;
Iz = (1-rho_z)*Iz_bar + rho_z*Iz(-1) + e_z0 + e_z1 + e_z2 - e_z0_neg - e_z1_neg - e_z2_neg;
z = Iz + (1-delta)*z(-1);
g = (1-rho_g)*g_bar  + rho_g*g(-1) + e_g0 + e_g1 + e_g2 - e_g0_neg - e_g1_neg - e_g2_neg;
end;

options_.simul.maxit = itermax;

initval;
n = 1;
a = 1;
z = 1;
R = (1/beta) - (1-delta);
k = (alpha/((1/beta)-(1-delta)))^(1/(1-alpha));
y = (alpha/((1/beta)-(1-delta)))^(alpha/(1-alpha));
I = delta*(alpha/((1/beta)-(1-delta)))^(1/(1-alpha));
w = (1-alpha)*(alpha/((1/beta)-(1-delta)))^(alpha/(1-alpha));
c = (alpha/((1/beta)-(1-delta)))^(alpha/(1-alpha)) - delta*(alpha/((1/beta)-(1-delta)))^(1/(1-alpha));
end;

@#include "rbc_shocks.mod"

steady;

options_.debug=1;
simul(periods=1000);
