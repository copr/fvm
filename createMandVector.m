function [M, vector] = createMandVector(nx, ny)
n = nx*ny;
M = sparse(n,n);
vector = zeros(n,1);
