function [Mout, vectorOut] = generateBoundaryEquations(bounds, Min, vectorIn, nx, ny)
% Vygeneruje Matici a vektor pravych stran pro kontrolni objemy  ktere
% JSOU na okrajich
Mout = Min;
vectorOut = vectorIn;
order = 1;
n = nx*ny;
for index=2:nx-1
    line = assign(index, 1, 0, 0, 0, 0, n, 1);
    Mout(order, :) = line;
    vectorOut(order) = bounds.w;
    order = order + 1;
end 
for index=n-nx+2:n-1
    line = assign(index, 1, 0, 0, 0, 0, n, 1);
    Mout(order, :) = line;
    vectorOut(order) = bounds.e;
    order = order+1;
end
for index=1:nx:n-nx+1
    line = assign(index, 1, 0, 0, 0, 0, n, 1);
    Mout(order, :) = line;
    vectorOut(order) = bounds.s;
    order = order + 1;
end 
for index=nx:nx:n
    line = assign(index, 1, 0, 0, 0, 0, n, 1);
    Mout(order, :) = line;
    vectorOut(order) = bounds.n;
    order = order+1;
end
end

