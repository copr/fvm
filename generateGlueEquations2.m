function [ M, vector ] = generateGlueEquations2(M, vector, i, nx, ny, left )
%generuje slepovaci rovnice left je flag ktery rika jestli generuju rovnice
%z leva nebo z prava 
for j=1:nx
    index = (i-1)*nx + j;
    M(index, :) = assign(index, -1, 0, 0, -1, 0, nx, ny);
    vector(index) = 0;
end
end

