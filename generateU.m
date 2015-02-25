function [Mu, vectorU] = generateU(nx ,ny , bounds, ro, gama, deltaX, deltaY, u, v, p)
Mu = zeros(nx*ny, nx*ny);
vectorU = zeros(nx*ny, 1);
for j=1:nx
    for i=1:ny
        [allF, allD] = generateFsandDsForU(i, j, u, v, ro, gama, deltaX, deltaY);
    end
end