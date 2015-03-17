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
bounds.u = u; % zadani okrajovych podminek 
bounds.v = v;

%type podminek 0 - zed, 1 - pohybujici se zed, 2 - inlet, 3 - outlet
types.ntype = 1; 
types.wtype = 0; 
types.etype = 0; 
types.stype = 0; 

bounds.movingWallSpeed = 1;
bounds.types = types;

Lx = 0.1;
Ly = 0.1;
n = 40;
gama = 0.01;
ro = 1;
my_ep = 0.000001;
Su = 0;
Sp = 0;

[ustar, vstar, pstar] = simple(n,n,bounds,Su, Sp,Lx,Ly,gama, ro, my_ep);

vykreslovaciFce = @(x) mesh(x);
figure('name', 'u');
vykreslovaciFce(ustar);
figure('name', 'v');
vykreslovaciFce(vstar);
figure('name', 'p');
vykreslovaciFce(pstar);
