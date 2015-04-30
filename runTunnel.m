v.e = 0;
v.n = 0;
v.s = 0;
v.w = 0;
v.e_is_d = true;
v.n_is_d = true;
v.s_is_d = true;
v.w_is_d = true;
u.e = 0;
u.n = 0;
u.s = 0;
u.w = 0.0001;
u.e_is_d = true;
u.n_is_d = true;
u.s_is_d = true;
u.w_is_d = true;
bounds.u = u; % zadani okrajovych podminek 
bounds.v = v;

%type podminek 0 - zed, 1 - pohybujici se zed, 2 - inlet, 3 - outlet
types.ntype = 0; 
types.wtype = 2; 
types.etype = 3; 
types.stype = 0; 

bounds.movingWallSpeed = 0;
bounds.types = types;

Lx = 50;
Ly = 10;
nx = 20;
ny = nx;
gama = 1;
ro = 10;
my_ep = 0.000000001;
Su = 0;
Sp = 0;
alfaU = 0.7;
alfaV = 0.7;
alfaP = 0.3;
maxIter = 5000;

Re = ro*v.s*Ly/gama

obstacles = zeros(nx, ny);
obstacles(10:20, 1:8) = 1;
obstacles(1:8, 12:20) = 1;

[ustar, vstar, pstar] = simple(nx,ny,bounds,Su, Sp,Lx,Ly,gama, ro, my_ep, alfaU, alfaV, alfaP, maxIter, obstacles);

[us,vs] = getCenters(ustar, vstar);
% streamline(0:nx-1, 0:ny-1, us, vs, 1, 1);

[x,y] = meshgrid(0:nx-1, 0:ny-1);
% 
figure
quiver(x,y,us,vs)

startx = 0:nx-1;
starty = 0:ny-1;
streamline(x,y,us,vs,startx,starty)

vykreslovaciFce = @(x) mesh(x);
figure('name', 'u');
vykreslovaciFce(ustar);
figure('name', 'v');
vykreslovaciFce(vstar);
figure('name', 'p');
vykreslovaciFce(pstar);
