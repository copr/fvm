function [] = fvm(u, v, ro, gama, Lx, Ly, NX, NY, bounds, Su, Sp)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
deltaX = Lx/NX;
deltaY = Ly/NY;
nx = NX;
ny = NY+1;
n = nx*ny;

A = sparse(n, n);
vectorA =  zeros(n,1);
B = sparse(2*(nx+2+ny), n);
vectorB = zeros(2*(nx+2+ny), 1);
G = sparse(nx, n);
vectorG = zeros(nx, 1);



%nastaveni kraju pro generovani okrajovych rovnic


[allF,allD] = generateFsandDs(nx, ny, u, v, ro, gama, deltaX, deltaY);


[A, vectorA] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, A, vectorA, nx, ny); %vygeneruju matici pro levou cast
full(A)
vectorA
sdfsd
[M, vector] = generateBoundaryEquations(bounds,NX, NY, allF, allD, sol2); %vygeneruju okraje pro kontrolni matici
[MGlued, vectorGlued] = generateGlueEquations(nx, ny); %vygeneruju slepovaci rovnice pro pravou stranu



%sol = pcg_chol(M, vector, 0.0000001);




figure(1);
mesh(solCheck);
figure(2);
mesh(solGlued);



end

