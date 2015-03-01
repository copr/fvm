function [ M, vector ] = relax( Min, vectorIn, alfa, nx, ny, old)
%relaxace 
D = diag(diag(Min));
M = (Min - D) + D./alfa;
uolds = reshape(old, nx*ny, 1);
vector = vectorIn + (1-alfa)*(diag(M)).*uolds;
end

