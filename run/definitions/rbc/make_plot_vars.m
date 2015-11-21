plot_vars = struct();

plot_vars.y = ssdev(y);
plot_vars.I = ssdev(I);
plot_vars.k = ssdev(k);
plot_vars.c = ssdev(c);
plot_vars.R = ssdev(R);
plot_vars.w = ssdev(w);
plot_vars.n = ssdev(n);
plot_vars.a = ssdev(a);
plot_vars.g = ssdev(g);
plot_vars.tau = ssdev(tau);
plot_vars.z = ssdev(z);
plot_vars.Iz = ssdev(Iz);

save plot_vars.mat plot_vars
