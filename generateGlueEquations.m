function [ M, vector ] = generateGlueEquations(M, vector, i, nx, ny )
for j=1:nx
    index = (i-1)*nx + j;
    line = assign(index, 1 , 0, 0, 1, 0, nx, ny);
    M(index, :) = line;
    vector(index) = 0;
end
end

