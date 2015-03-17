v.e = 0;
v.n = 0;
v.s = 0;
v.w = 0;
v.e_is_d = false;
v.n_is_d = true;
v.s_is_d = true;
v.w_is_d = true;
u.e = 0;
u.n = 0;
u.s = 0;
u.w = 0.01;
u.e_is_d = false;
u.n_is_d = true;
u.s_is_d = true;
u.w_is_d = true;
bounds.u = u; % zadani okrajovych podminek 
bounds.v = v;

%type podminek 0 - zed, 1 - pohybujici se zed, 2 - inlet, 3 - outlet
types.ntype = 0; 
types.wtype = 2; 
types.etype = 2; 
types.stype = 0; 

bounds.movingWallSpeed = 0;
bounds.types = types;

Lx = 5;
Ly = 5;
n = 30;
gama = 1;
ro = 1;
my_ep = 0.000001;
Su = 0;
Sp = 0;

Re = ro*v.s*Ly/gama

[ustar, vstar, pstar] = simple(n,n,bounds,Su, Sp,Lx,Ly,gama, ro, my_ep);

vykreslovaciFce = @(x) mesh(x);
figure('name', 'u');
vykreslovaciFce(ustar);
figure('name', 'v');
vykreslovaciFce(vstar);
figure('name', 'p');
vykreslovaciFce(pstar);
