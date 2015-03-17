function [ M, vector ] = generateGlueEquations(M, vector, i, nx, ny, left )
for j=1:nx
    index = (i-1)*nx + j;
    if left
        index2 = (i+1)*nx + j;
    else
        index2 = (i-3)*nx + j;
    end
    line = sparse(nx*ny, 1);
    line(index) = 1;
    line(index2) = -1;
    M(index, :) = line;
    vector(index) = 0;
end
end

