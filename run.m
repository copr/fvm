v.e = 0;
v.n = 0;
v.s = 0;
v.w = 0;
v.e_is_d = true;
v.n_is_d = true;
v.s_is_d = true;
v.w_is_d = true;
u.e = 1;
u.n = 0;
u.s = 0;
u.w = 0;
u.e_is_d = true;
u.n_is_d = true;
u.s_is_d = true;
u.w_is_d = true;
bounds.u = u;

types.ntype = 1; %inlet
types.wtype = 0; %wall
types.etype = 0; %wall
types.stype = 2; %outlet

bounds.types = types;

Lx = 0.1;
Ly = 0.1;

n = 20;
bounds.v = v;

vykreslovaciFce = @(x) surface(x);

[ustar, vstar, pstar] = simpleAlgorithm(n,n,bounds,0,0,0.1,0.1,1,1, 0.00001);

figure('name', 'u');
vykreslovaciFce(ustar);
figure('name', 'v');
vykreslovaciFce(vstar);
figure('name', 'p');
vykreslovaciFce(pstar);
