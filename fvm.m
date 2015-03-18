function [] = fvm(u, v, ro, gama, Lx, Ly, NX, NY, bounds, Su, Sp)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
deltaX = Lx/NX;
deltaY = Ly/NY;
nx = NX;
ny = NY+2;
n = nx*ny;


sol = zeros(nx, ny);
sol2 = zeros(NX, NY);

%nastaveni kraju pro generovani okrajovych rovnic
sol(1,:) = bounds.s;
sol(:,1) = bounds.w;
sol(end, :) = bounds.n;
sol(:, end) = bounds.e;

sol2(1,:) = bounds.s;
sol2(:,1) = bounds.w;
sol2(end, :) = bounds.n;
sol2(:, end) = bounds.e;

Mleft = sparse(n, n); vectorL = zeros(n, 1);
Mright = sparse(n, n); vectorR = zeros(n, 1);
M = sparse(NX*NY, NX*NY); vector = zeros(NX*NY, 1);

[allF,allD] = generateFsandDs(n, u, v, ro, gama, deltaX, deltaY);


[Mleft, vectorL] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, Mleft, vectorL, NX, nx, ny ...
    , 2, floor(ny/2), 2, nx-1); %vygeneruju matici pro levou cast

[Mright, vectorR] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, Mright, vectorR, NX, nx, ny ...
    , floor(ny/2)+3, ny-1, 2, nx-1); %vygeneruju matici pro pravou cast

[M, vector] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, M, vector, NX, NX, NY...
    , 2, NY-1, 2, NX-1);  %vygeneruju si matici pro cele at si to muzu vyzkouset
% Mleft
% size(Mleft)
% Mright
MGlued = Mleft + Mright; %dam do kupy obe matice
vectorGlued = vectorL + vectorR; %spojim vektory

[M, vector] = generateBoundaryEquations(bounds, M, vector, NX, NY, allF, allD, sol2); %vygeneruju okraje pro kontrolni matici
[MGlued, vectorGlued] = generateBoundaryEquations(bounds, MGlued, vectorGlued, nx, ny, allF, allD, sol); % vygeneruju okrajove rovnice pro slepenou matici
[MGlued, vectorGlued] = generateGlueEquations(MGlued, vectorGlued, floor(ny/2)+1, nx, ny, true); %vygeneruju slepovaci rovnice pro levou stranu
[MGlued, vectorGlued] = generateGlueEquations(MGlued, vectorGlued, floor(ny/2)+2, nx, ny, false); %vygeneruju slepovaci rovnice pro pravou stranu


solG = MGlued\vectorGlued;
solCh = M\vector;
%sol = pcg_chol(M, vector, 0.0000001);




solCheck = reshape(solCh, NX, NY);
solGlued = reshape(solG, nx, ny);

solGlued(:,floor(ny/2)+2) = [];
solGlued(:,floor(ny/2)+1) = []; %vyhodim ty sloupce ktere funguji jako lepeni

solCheck
solGlued

figure(1);
mesh(solCheck);
figure(2);
mesh(solGlued);



end

