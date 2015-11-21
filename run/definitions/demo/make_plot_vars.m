plot_vars = struct();

# make helping variables for report
blag     = [bo b(1:751)']'; 
dclag    = [dco dc(1:751)']';
dlag     = [d_o d(1:751)']';
rstarlag = [r_f+nu rstar(1:751)']'; 
r_dclag  = [r_f+nug r_dc(1:751)']'; 
rlag     = [ro r(1:751)']';
bstarlag = [bstaro bstar(1:751)']'; 
qxlag    = [q_xo qx(1:751)']';
qnlag    = [q_no qn(1:751)']';
ixn      = ix + in;
rer      = pn ./ px;
wr       = w ./ p;
c        = (e+eh) .* p;

# make plot variables 

# batch 1 = percent of GDP
plot_vars.b         = 100 * p .* b ./ ynom;
plot_vars.bstar     = 100 * bstar ./ ynom;
plot_vars.cad       = 100 * (d + dc + bstar - (dlag + dclag + bstarlag)./(1+g)) ./ ynom;
plot_vars.d         = 100 * d ./ ynom;
plot_vars.dc        = 100 * dc ./ ynom;
plot_vars.grants    = 100 * grants ./ ynom;
plot_vars.iz        = iz .* pz;
plot_vars.oilr      = 100 * oilr ./ ynom;
plot_vars.pfd       = 100 * (p.*(b-blag)+d-dlag+dc-dclag-(r_d-g).*dlag./(1+g)-(r_dclag-g).*dclag./(1+g)-(rlag-g).*p.*blag/(1+g)) ./ ynom;
plot_vars.totaldebt = 100 * (p.*b + d + dc) ./ ynom;

# batch 2 = index (make all indices set to 100)
plot_vars.p     = 100 * p;
plot_vars.pk    = 100 * pk;
plot_vars.pn    = 100 * pn;
plot_vars.pz    = 100 * pz;
plot_vars.px    = 100 * px;
plot_vars.pm    = 100 * pm;
plot_vars.pmm   = 100 * pmm;
plot_vars.tot   = 100 * (px./pm);
plot_vars.totmm = 100 * (px./pmm);
plot_vars.ynom  = ynom;

# batch 3 = percent
plot_vars.growth = 100 * ((qn-qnlag)./qnlag + (qx-qxlag)./qxlag + g);
plot_vars.h      = 100 * h;
plot_vars.r      = 100 * r;
plot_vars.rstar  = 100 * rstar;
plot_vars.r_dc   = 100 * r_dc;

# batch 4 = percent change from initial level
plot_vars.c   = 100 * (c - c(1)) / c(1);
plot_vars.ze  = 100 * (ze - ze(1)) / ze(1);
plot_vars.T   = 100 * (T - T(1)) / T(1);
plot_vars.kn  = 100 * (kn - kn(1)) / kn(1);
plot_vars.in  = 100 * (in - in(1)) / in(1);
plot_vars.L_n = 100 * (L_n - L_n(1)) / L_n(1);
plot_vars.qn  = 100 * (qn - qn(1)) / qn(1);
plot_vars.rn  = 100 * (rn - rn(1)) / rn(1);
plot_vars.ixn = 100 * (ixn - ixn(1)) / ixn(1);
plot_vars.z   = 100 * (z - z(1)) / z(1);
plot_vars.rer = 100 * (rer - rer(1)) / rer(1);
plot_vars.wr  = 100 * (wr - wr(1)) / wr(1);
plot_vars.Rz  = 100 * (Rz - Rz(1)) / Rz(1);
plot_vars.kx  = 100 * (kx - kx(1)) / kx(1);
plot_vars.ix  = 100 * (ix - ix(1)) / ix(1);
plot_vars.L_x = 100 * (L_x - L_x(1)) / L_x(1);
plot_vars.qx  = 100 * (qx - qx(1)) / qx(1);
plot_vars.rx  = 100 * (rx - rx(1)) / rx(1);

# save
save plot_vars.mat plot_vars;
