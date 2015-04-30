function [] = fvm(u, v, ro, gama, Lx, Ly, nx, ny, bounds, Su, Sp)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
deltaX = Lx/nx;
deltaY = Ly/ny;
n = nx*ny;
M = zeros(n, n);
vector = zeros(n, 1);


[allF,allD] = generateFsandDs(n, u, v, ro, gama, deltaX, deltaY);
% [M, vector] = generateNonBoundaryEquations(Su, Sp, allF, allD, M, vector, nx, ny);
% [M, vector] = generateBoundaryEquations(bounds, M, vector, nx, ny, allF, allD);

for j=1:nx
    for i=1:ny
        index = (i-1)*nx + j;
        if isOnBoundary(j, i, nx, ny)
            [equation, rhs] = generateBoundaryEquation(i, j, bounds, nx, ny, allF, allD);
        else
            [equation, rhs] = generateNonBoundaryEquation(j, i, deltaX*deltaY*Su, deltaX*deltaY*Sp, allF, allD, nx, ny);
        end
        M(index, :) = equation;
        vector(index) = rhs;
    end
end


sol = M\vector;

solMatrix = reshape(sol, nx, ny);

mesh(solMatrix);


end

