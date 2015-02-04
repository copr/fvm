function sol = fvm2d(x, y, nx, ny, bounds, Su, Sp, gama, ro, u, v)
% x = 0.4; y = 0.3; nx = 40; ny = 30; A = 0.010; gama = 1000;Su = 0;Sp = 0;
%bounds = struct('n', 100, 'n_is_d', true, 's', 0, 's_is_d', false, ...
%        'w', 500000, 'w_is_d', false, 'e', 0, 'e_is_d', false);
%
%bounds je struktura okrajovych podminek 'n_is_d' rika jestli to je
%dirichletova podminka a 'n' udava hodnotu podminky
if size(Su) == [1, 1]
    Su = ones(nx, ny) .* Su;
end
if size(u) == [1, 1]
    u = ones(nx, ny) .* u;
end
if size(v) == [1, 1]
    v = ones(nx, ny) .* v;
end
if size(ro) == [1, 1]
    ro = ones(nx, ny) .* ro;
end
if size(gama) == [1, 1]
    gama = ones(nx, ny) .* gama;
end
n = nx*ny;
M = zeros(n,n);
vector = zeros(n,1);
deltaX = x/nx;
deltaY = y/ny;
dV = deltaX*deltaY;
for i=1:n
    [ap,an,as,ae,aw,Source] = ...
        coefficients(i, gama, deltaX, deltaY, Su.*dV, Sp.*dV, nx,ny, bounds, ro, u, v); 
    line = assign(i, ap, an, as, ae, aw, nx, ny);
    M(i,1:end) = line;
    vector(i) = Source;
end
sol = M \ vector;
end