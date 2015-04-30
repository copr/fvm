function [ uObstacles, vObstacles, pObstacles ] = generateObstacles(obstaclesGrid, nx, ny)
%ze zadanyh prekazek vygeneruje matici kde jednicky ukazuji kde maji byt
%prekazky pro jednotlive pocitane veliciny
[onx, ony] = size(obstaclesGrid);
uObstacles = zeros(nx + 2, ny + 1);
vObstacles = zeros(nx + 1, ny + 2);
pObstacles = zeros(nx + 2, ny + 2);

if onx + ony ~= 2
    for i=1:ny
        for j=1:nx
            if obstaclesGrid(j, i)
                pObstacles(j+1, i+1) = 1;
                uObstacles(j+1, i) = 1;
                uObstacles(j+1, i+1) = 1;
                vObstacles(j, i+1) = 1;
                vObstacles(j+1, i+1) = 1;
            end
        end
    end
end
end

