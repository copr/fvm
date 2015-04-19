function [Mout, vectorOut] = generateBoundaryEquations(Min, vectorIn, nx, ny, vals)
% Vygeneruje Matici a vektor pravych stran pro kontrolni objemy  ktere
% JSOU na okrajich
Mout = Min;
vectorOut = vectorIn;
order = 1;
n = nx*ny;
for index=2:nx-1
    j = rem(index-1, nx) + 1;
    i =	floor((index-1)/nx) + 1;
    line = assign(index, 1, 0, 0, 0, 0, n, 1);
    Mout(order, :) = line;
    vectorOut(order) = vals(j, i);
    order = order + 1;
end 
for index=n-nx+2:n-1
    j = rem(index-1, nx) + 1;
    i =	floor((index-1)/nx) + 1;
    line = assign(index, 1, 0, 0, 0, 0, n, 1);
    Mout(order, :) = line;
    vectorOut(order) = vals(j, i);
    order = order + 1;
end
for index=1:nx:n-nx+1
    j = rem(index-1, nx) + 1;
    i =	floor((index-1)/nx) + 1;
    line = assign(index, 1, 0, 0, 0, 0, n, 1);
    Mout(order, :) = line;
    vectorOut(order) = vals(j, i);
    order = order + 1;
end 
for index=nx:nx:n
    j = rem(index-1, nx) + 1;
    i =	floor((index-1)/nx) + 1;
    line = assign(index, 1, 0, 0, 0, 0, n, 1);
    Mout(order, :) = line;
    vectorOut(order) = vals(j, i);
    order = order + 1;
end
end

