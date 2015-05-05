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

nx = 70;
ny = nx;
bounds.v = v;

gama = 0.01;
ro = 1;

Re = u.n * ro * Lx/ gama

vykreslovaciFce = @(x) surface(x);



[ustar, vstar, pstar] = simpleAlgorithm(nx,ny,bounds,0,0,0.1,0.1,gama, ro, 0.000001);

figure('name', 'u');
vykreslovaciFce(ustar);
figure('name', 'v');
vykreslovaciFce(vstar);
figure('name', 'p');
vykreslovaciFce(pstar);

[us,vs] = getCenters(ustar, vstar);
[x,y] = meshgrid(0:nx-1, 0:ny-1);

figure
quiver(x,y,us,vs)

startx = 0:nx-1;
starty = 0:ny-1;
streamline(x,y,us,vs,startx,starty)

figure('name', 'magnitude');
vykreslovaciFce(sqrt(us.^2 + vs.^2));

