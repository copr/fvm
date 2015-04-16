function [Mout, vectorOut] = generateBoundaryEquations(Min, vectorIn, n, nx)
% Vygeneruje Matici a vektor pravych stran pro kontrolni objemy  ktere
% JSOU na okrajich
Mout = Min;
vectorOut = vectorIn;
order = 1;
for index=1:n
    line = assign(index, 1, 0, 0, 0, 0, nx, 1);
    Mout(order, :) = line;
    vectorOut(order) = 0;
    order = order + 1;
end 
for index=nx-n+1:nx
    line = assign(index, 1, 0, 0, 0, 0, nx, 1);
    Mout(order, :) = line;
    vectorOut(order) = 0;
    order = order+1;
end
end

