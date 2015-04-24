v.e = 0;
v.n = 0;
v.s = 0.01;
v.w = 0;
v.e_is_d = true;
v.n_is_d = true;
v.s_is_d = true;
v.w_is_d = true;
u.e = 0;
u.n = 0;
u.s = 0.5;
u.w = 0;
u.e_is_d = true;
u.n_is_d = true;
u.s_is_d = true;
u.w_is_d = true;
bounds.u = u; % zadani okrajovych podminek 
bounds.v = v;

%type podminek 0 - zed, 1 - pohybujici se zed, 2 - inlet, 3 - outlet
types.ntype = 3; 
types.wtype = 0; 
types.etype = 0; 
types.stype = 2; 

bounds.movingWallSpeed = 1;
bounds.types = types;

Lx = 1;
Ly = 10;
nx = 20;
ny = 20;
gama = 1;
ro = 10;
my_ep = 0.0001;
Su = 0;
Sp = 0;
alfaU = 0.7;
alfaV = alfaU;
alfaP = 0.1;
maxIter = 1000;

Re = ro*v.s*Ly/gama

[ustar, vstar, pstar] = simple(nx,ny,bounds,Su, Sp,Lx,Ly,gama, ro, my_ep, alfaU, alfaV, alfaP, maxIter);

[us,vs] = getCenters(ustar, vstar);
% streamline(0:nx-1, 0:ny-1, us, vs, 1, 1);

[x,y] = meshgrid(0:nx-1, 0:ny-1);
% 
% figure
% quiver(x,y,us,vs)
% 
% startx = 0:nx-1;
% starty = 0:ny-1;
% streamline(x,y,us,vs,startx,starty)

vykreslovaciFce = @(x) surface(x);
figure('name', 'u');
vykreslovaciFce(ustar);
figure('name', 'v');
vykreslovaciFce(vstar);
figure('name', 'p');
vykreslovaciFce(pstar);
