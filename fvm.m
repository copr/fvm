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




[allF,allD] = generateFsandDs(nx, ny, u, v, ro, gama, deltaX, deltaY);

[A, vectorA] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, A, vectorA, NX, NY, NX+10); 
[B, vectorB] = generateBoundaryEquations(B, vectorB, NX, NX*NY); %vytvareni okrajovych rovnic
[Bx, ~] = size(B);
M = [A B'; B zeros(Bx, Bx)];
res_ = M \ [vectorA; vectorB];
%res = reshape(res_, NX, NY+Bx/NY);
res_restr = res_(1:end-Bx);
res = reshape(res_restr , NX, []);  
% vykreslime jen tzv. primarni promenne, Lagrangeovy multiplikatory (tzv. dualni promenne) zde nemaji co delat

figure('name', 'jen okraje')
mesh(res);
%size(res)

[A1, vectorA1] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, A1, vectorA1, nxA1, nyA1, nxA1+10); %generovani jedne matice
[A2, vectorA2] = generateNonBoundaryEquations(Su.*(deltaX*deltaY), Sp.*(deltaX*deltaY), allF, allD, A2, vectorA2, nxA2, nyA2, 1);  %generovani druhe matice
[B1, vectorB1] = generateBoundaryEquations(B1, vectorB1, NX, NX*(NY+1)); %generovani okraju
[G, vectorG] = generateGlueEquations(G, vectorG, floor(ny/2), NX, NX*(NY+1)); %vygeneruju slepovaci rovnice
BG = [B1;G]; %spojeni okrajove a slepovaci matice
[BGx, ~] = size(BG);
[X1, Y1] = size(A1);
[X2, Y2] = size(A2);
bigA = [A1 sparse(X1, Y2); sparse(X2, Y1) A2]; %spojeni dvou casti domeny 
vectorBigA = [vectorA1; vectorA2];
M = [bigA, BG'; BG zeros(BGx, BGx)]; %spojeni matic s okrajemi a slepenim
V = [vectorBigA; vectorB1; vectorG];


sol_ = M\V;
%sol = reshape(sol_, nx, ny+BGx/nx);

% 1) vykreslime jen tzv. primarni promenne, Lagrangeovy multiplikatory
%    (tzv. dualni promenne) zde nemaji co delat
% 2) jeste navic potrebujeme udelat restrikci reseni na puvodni pocet neznamych
% 3) pro ted: predpokladam, ze prvnich [size(G,1)] neznamych v druhe subdomene
%    je zdvojenych - obecne bych to potrebovala mit nekde ulozeno 
%    cislovani uzlu globalniho (puvodniho, nedekomponovaneho) problemu
%    a odpovidajici cislovani lokalniho (noveho, dekomponovaneho,
%    zdvojeneho) problemu
sol_restr = sol_([1:200,201+size(G,1):end-BGx]);

sol = reshape(sol_restr, nx, []);
figure('name', 'slepene')
%res
%sol
mesh(sol);

%"error"
max(abs([res_restr - sol_restr]))

%keyboard





end

