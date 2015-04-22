function [] = fvm(u, v, ro, gama, Lx, Ly, nx, ny, bounds, Su, Sp, Mnx, Mny)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
deltaX = Lx/nx;
deltaY = Ly/ny;
n = nx*ny;


[allF,allD] = generateFsandDs(nx, ny, u, v, ro, gama, deltaX, deltaY);
% [M, vector] = generateNonBoundaryEquations(Su, Sp, allF, allD, M, vector, nx, ny);
% [M, vector] = generateBoundaryEquations(bounds, M, vector, nx, ny, allF, allD);
[bigMatrix, bigVector] = generateSeperateMatrices(Su .* (-deltaX*deltaY), Sp .* deltaX*deltaY, allF, allD, nx, ny, Mnx, Mny, zeros(size(Su)));

% sol = bigMatrix\bigVector;
% 
% solMatrix = reshape(sol, nx, ny);
% 
% mesh(solMatrix);


end

