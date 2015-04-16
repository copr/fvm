function [] = fvm(u, v, ro, gama, Lx, Ly, NX, NY, bounds, Su, Sp)

deltaX = Lx/NX;
deltaY = Ly/NY;
nx = NX;
ny = NY+1;
n = nx*ny;

A = sparse(NX*NY, NX*NY);
vectorA = zeros(NX*NY, 1);

B = sparse(NX, NX*NY);
vectorB = zeros(NX, 1);

nxA1 = NX;
nyA1 = floor((NY+1)/2);
nA1 = nxA1*nyA1;

nxA2 = NX;
nyA2 = ceil((NY+1)/2);
nA2 = nxA2*nyA2;

A1 = sparse(nA1, nA1);
vectorA1 =  zeros(nA1,1);
A2 = sparse(nA2, nA2);
vectorA2 =  zeros(nA2,1);
B1 = sparse(NX, NX*(NY+1));
vectorB1 = zeros(NX, 1);
G = sparse(NX, NX*(NY+1));
vectorG = zeros(NX, 1);


%nastaveni kraju pro generovani okrajovych rovnic


[allF,allD] = generateFsandDs(nx, ny, u, v, ro, gama, deltaX, deltaY);

[A, vectorA] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, A, vectorA, NX, NY, NX+10); 
[B, vectorB] = generateBoundaryEquations(B, vectorB, NX, NX*NY);
[Bx, ~] = size(B);
M = [A B'; B zeros(Bx, Bx)];
res = M \ [vectorA; vectorB];
res = reshape(res, NX, NY+Bx/NY);
figure(2)
mesh(res);
%size(res)

[A1, vectorA1] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, A1, vectorA1, nxA1, nyA1, nxA1+10); 
[A2, vectorA2] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, A2, vectorA2, nxA2, nyA2, 1); 
[B1, vectorB1] = generateBoundaryEquations(B1, vectorB1, NX, NX*(NY+1)); 
[G, vectorG] = generateGlueEquations(G, vectorG, floor(ny/2), NX, NX*(NY+1)); %vygeneruju slepovaci rovnice
BG = [B1;G];
[BGx, ~] = size(BG);
[X1, Y1] = size(A1);
[X2, Y2] = size(A2);
bigA = [A1 sparse(X1, Y2); sparse(X2, Y1) A2];
vectorBigA = [vectorA1; vectorA2];
M = [bigA, BG'; BG zeros(BGx, BGx)];
V = [vectorBigA; vectorB1; vectorG];


sol = M\V;
size(sol)
sol = reshape(sol, nx, ny+BGx/nx);
size(sol)
figure(1)
res
sol
mesh(sol);
%sol = pcg_chol(M, vector, 0.0000001);







end

