function [ M, vector ] = generateGlueEquations(M, vector, i, nx, n)
%generuje slepovaci rovnice
index = 1;
for j=(i-1)*nx+1:(i-1)*nx+nx
    line = sparse(1, n);
    line(j) = 1;
    line(j+nx) = -1;
    M(index, :) = line;
    vector(index) = 0;
    index = index+1;
end
end

