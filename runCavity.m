clear;

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
types.ntype = 2; 
types.wtype = 0; 
types.etype = 0; 
types.stype = 0; 

bounds.movingWallSpeed = 1;
bounds.types = types;

Lx = 0.1;
Ly = 0.1;
nx = 20;
ny = nx;
gama = 0.001;
ro = 10;
my_ep = 0.00000001;
Su = 0;
Sp = 0;
alfaU = 0.7;
alfaV = alfaU;
alfaP = 0.3;
maxIter = 1000;

Re = ro*bounds.movingWallSpeed*Ly/gama

obstacles = zeros(nx, ny);
obstacles(end-10:end-3, 6:10) = 1;

GhiaU100 = dlmread('GhiaU100');
GhiaU100y = dlmread('GhiaU100y');
GhiaV100 = dlmread('GhiaV100');
GhiaV100x = dlmread('GhiaV100x');

[ustar, vstar, pstar] = simple(nx,ny,bounds,Su, Sp,Lx,Ly,gama, ro, my_ep, alfaU, alfaV, alfaP, maxIter, obstacles);
[us,vs] = getCenters(ustar, vstar);
% 
[x,y] = meshgrid(0:nx-1, 0:ny-1);

figure
quiver(x,y,us,vs)

startx = 0:nx-1;
starty = 0:ny-1;
streamline(x,y,us,vs,startx,starty)

[~, uny] = size(ustar);
% 
% deltaY = Ly/ny;
% deltaX = Lx/nx;
% 
% figure('name', 'porovnani U');
% hold on;
% plot(GhiaU100, GhiaU100y, 'r*')
% plot(ustar(2:end-1, ny/2), deltaY/2:deltaY:Ly)
% hold off;
% figure('name', 'porovnani V');
% hold on;
% plot(GhiaV100, GhiaV100x, 'g*')
% plot(vstar(nx/2, 2:end-1), deltaX/2:deltaX:Lx)
% hold off;
% % % 
% dlmwrite(sprintf('%s%d%d%d.dat', 'ustar', Re, nx), ustar)
% dlmwrite(sprintf('%s%d%d%d.dat', 'vstar', Re, nx), vstar)
% dlmwrite(sprintf('%s%d%d%D.dat', 'pstar', Re, nx), pstar)

vykreslovaciFce = @(x) surface(x);
figure('name', 'magnitude');
vykreslovaciFce(sqrt(us.^2+vs.^2));
figure('name', 'u');
vykreslovaciFce(ustar);
figure('name', 'v');
vykreslovaciFce(vstar);
figure('name', 'p');
vykreslovaciFce(pstar);