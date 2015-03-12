function [] = fvm(u, v, ro, gama, Lx, Ly, NX, NY, bounds, Su, Sp)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
deltaX = Lx/NX;
deltaY = Ly/NY;
nx = NX;
ny = NY+2;
n = nx*ny;
M = sparse(n, n);
vector = zeros(n, 1);

sol = zeros(n,n);
sol(1,:) = bounds.s;
sol(:,1) = bounds.w;
sol(end, :) = bounds.n;
sol(:, end) = bounds.e;

 Mleft = sparse(n, n); vectorL = zeros(n, 1);
 Mright = sparse(n, n); vectorR = zeros(n, 1);

[allF,allD] = generateFsandDs(n, u, v, ro, gama, deltaX, deltaY);


[Mleft, vector] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, Mleft, vector, NX, nx, ny ...
    , 2, floor(ny/2), 2, nx-1, true);

[Mright, vector] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, Mright, vector, NX, nx, ny ...
    , floor(ny/2)+2, ny-1, 2, nx-1, false);
% Mleft
% size(Mleft)
% Mright
M = Mleft + Mright;

[M, vector] = generateBoundaryEquations(bounds, M, vector, nx, ny, allF, allD, sol);
[M, vector] = generateGlueEquations(M, vector, floor(ny/2)+1, nx, ny);



sol = M\vector;

if NX == 4
    M
    sol
    vector
end
%sol = pcg_chol(M, vector, 0.0000001);

solMatrix = reshape(sol, nx, ny);


mesh(solMatrix);


end

