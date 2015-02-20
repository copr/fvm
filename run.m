v.e = 0;
v.n = 0;
v.s = 0;
v.w = 0;
v.e_is_d = true;
v.n_is_d = true;
v.s_is_d = true;
v.w_is_d = true;
u.e = 0;
u.n = 1;
u.s = 0;
u.w = 0;
u.e_is_d = true;
u.n_is_d = true;
u.s_is_d = true;
u.w_is_d = true;
bounds.u = u;

% 0 - zed, 1 - pohybujici se zed, 2 - inlet, 3 - outlet
types.ntype = 2; 
types.wtype = 0; 
types.etype = 0; 
types.stype = 0; 

bounds.types = types;

Lx = 0.1;
Ly = 0.1;

n = 20;
bounds.v = v;

vykreslovaciFce = @(x) surface(x);

gama = 0.01;
ro = 1;

[ustar, vstar, pstar] = simpleAlgorithm(n,n,bounds,0,0,0.1,0.1,gama, ro, 0.000001);

figure('name', 'u');
vykreslovaciFce(ustar);
figure('name', 'v');
vykreslovaciFce(vstar);
figure('name', 'p');
vykreslovaciFce(pstar);
