function [] = fvm(u, v, ro, gama, Lx, Ly, NX, NY, bounds, Su, Sp)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
deltaX = Lx/NX;
deltaY = Ly/NY;
nx = NX;
ny = NY+1;
n = nx*ny;
vector = zeros(n, 1);

sol = zeros(nx, ny);
sol2 = zeros(NX, NY);

sol(1,:) = bounds.s;
sol(:,1) = bounds.w;
sol(end, :) = bounds.n;
sol(:, end) = bounds.e;

sol2(1,:) = bounds.s;
sol2(:,1) = bounds.w;
sol2(end, :) = bounds.n;
sol2(:, end) = bounds.e;

 Mleft = sparse(n, n); vectorL = zeros(n, 1);
 Mright = sparse(n, n); vectorR = zeros(n, 1);
 MT = sparse(NX*NY, NX*NY); vectorT = zeros(NX*NY, 1);

[allF,allD] = generateFsandDs(n, u, v, ro, gama, deltaX, deltaY);


[Mleft, vector] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, Mleft, vector, NX, nx, ny ...
    , 2, floor(ny/2), 2, nx-1, true);

[Mright, vector] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, Mright, vector, NX, nx, ny ...
    , floor(ny/2)+2, ny-1, 2, nx-1, false);

[MT, vectorT] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, MT, vectorT, NX, NX, NY...
    , 2, NY-1, 2, NX-1, false); 
% Mleft
% size(Mleft)
% Mright
M = Mleft + Mright;

[MT, vectorT] = generateBoundaryEquations(bounds, MT, vectorT, NX, NY, allF, allD, sol2);
[M, vector] = generateBoundaryEquations(bounds, M, vector, nx, ny, allF, allD, sol);
[M, vector] = generateGlueEquations(M, vector, floor(ny/2)+1, nx, ny);

full(MT);
vectorT;

sol = M\vector;
solT = MT\vectorT;
%sol = pcg_chol(M, vector, 0.0000001);
if NX == 4
    full(M)
    vector
    sol
end



solMatrix = reshape(sol, nx, ny);
solTogether = reshape(solT, NX, NY);

figure(1);
mesh(solMatrix);
figure(2);
mesh(solTogether);



end

