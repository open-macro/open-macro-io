function [JJ]=costoverrun(x, cc, delta, ee, g, i_0, k_0);

# x is the adjustment costs parameter phi
JJ = cc - (x/2)*((1-delta)/((1+g)-(ee*i_0/k_0))-1)^2*((1+g)*k_0/i_0-ee/(1-delta));
