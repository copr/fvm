function [ustar, vstar, pstar] = simple(nx, ny, bounds, Su, Sp, Lx, Ly, gama, ro, my_ep, alfaU, alfaV, alfaP, maxIter, obstacles)
%hlavni funkce pro spusteni SIMPLu
%okrajove podminky jsou zadany pomoci rovnic
%nx - pocet objemu na ose x, ny - pocet kontrolnich objemu na ose y,
%bounds - okrajove podminky, Su,Sp - zdroje, Lx,Ly - delka oblasti v x,y
%gama - difuzni koeficinent, ro - hustota, my_ep - pozadovana presnot
%alfa - relaxace jednotlivych vypoctu
%ustar - napocitane rychlosti ve smeru osy x, vstar - ve smeru y
%pstar - tlaakove pole


[ustar, vstar, pstar] = initUVPstar(nx, ny, bounds);
[unx, uny] = size(ustar);
[vnx, vny] = size(vstar);
[pnx, pny] = size(pstar);

[uObstacles, vObstacles, pObstacles] = generateObstacles(obstacles, nx, ny);



deltaX = Lx/nx;
deltaY = Ly/ny;

% ustar(:,1) = 0;
% ustar(8:14, 1) = 0.01;

Mu = sparse(unx*uny, unx*uny);
vectorU = zeros(unx*uny, 1);
Mv = sparse(vnx*vny, vnx*vny);
vectorV = zeros(vnx*vny, 1);

vectorP = ones(pnx*pny, 1);

vold = zeros(vnx, vny);
uold = zeros(unx, uny);
% sources = ones(pnx, pny);

f1 = figure(1);
f2 = figure(2);
f3 = figure(3);
movegui(f1, [50, 500]);
movegui(f2, [700, 500]);
movegui(f3, [1300, 500]);

it = 0;
while it < maxIter && ~convergence(vectorP, my_ep)
%     ustar
%     vstar
    it = it+1
   % ustar
    SU = zeros(unx, uny); SV = zeros(vnx, vny); SUp = zeros(unx, uny); SVp = zeros(vnx, vny);
    
    %spocita zdroje ktere vychazeji z toho ze na okrajich jsou zadane zdi
    [SUp, SVp, SU, SV] = calcSourceTermsArisingFromWalls(bounds, SUp, SVp, SU, SV, deltaX, deltaY, gama);

    %spocita zdroje, ktere vychazeji z hodnot tlaku
    SU = calcSourcesFromPressureForU(SU, pstar, unx, uny, deltaX, deltaY);
    SV = calcSourcesFromPressureForV(SV, pstar, vnx, vny, deltaX, deltaY);
%     SU
    
%     ustar
%     vstar
    
    [FsForU, DsForU] = generateFsandDsForU(ustar, vstar, ro, gama, deltaX, deltaY); % generovani koeficientu pro vsechny rovnice
    [FsForV, DsForV] = generateFsandDsForV(ustar, vstar, ro, gama, deltaX, deltaY);

    [Mu, vectorU] = generateNonBoundaryEquations(SU, SUp, FsForU, DsForU, Mu, vectorU, unx, uny); % vygeneruje matici pro u s rovnicemi pro vsechny neokrajove prvky
    [Mu, vectorU] = relax(Mu, vectorU, alfaU, unx, uny, uold); % relaxace je uprostred aby nezmenily uz okrajove rovnice
    [Mu, vectorU] = generateBoundaryEquations(bounds.u, Mu, vectorU, unx, uny, FsForU, DsForU, ustar, uObstacles); % do matice mu vygeneruje rovnice pro okrajove prvky
    
    [Mv, vectorV] = generateNonBoundaryEquations(SV, SVp, FsForV, DsForV, Mv, vectorV, vnx, vny); %to same jako predtim pro v
    [Mv, vectorV] = relax(Mv, vectorV, alfaV, vnx, vny, vold);
    [Mv, vectorV] = generateBoundaryEquations(bounds.v, Mv, vectorV, vnx, vny, FsForV, DsForV, vstar, vObstacles);
    
    uold = ustar;
    vold = vstar;
    %vyreseni rovnic 
    ustar = Mu\vectorU;
    ustar = reshape(ustar, unx, uny);
    
    vstar = Mv\vectorV;
    vstar = reshape(vstar, vnx, vny);

    

    [Mp, vectorP, sources] = generetaPresureCorrectEqs(pstar, ustar, vstar, ro, deltaX, deltaY, Mu, Mv, pObstacles); % vytvoreni rovnci tlakovych korekci
%     
    offset = 2;
    Mp(pnx+offset, :) = zeros(1, length(Mp(1,:)));
    Mp(pnx+offset,pnx+offset) = 1;
    vectorP(pnx+offset) = 0; %upevneni tlaku
    pcomma = Mp\vectorP; 
    
%     pcomma = pcg_chol(Mp, vectorP, my_ep);

    pcomma = reshape(pcomma, pnx, pny);
    
    %korekce
    pstar = correctP(pcomma, pstar, alfaP);
    ustar = correctU(pcomma, ustar, deltaY, Mu);
    vstar = correctV(pcomma, vstar, deltaX, Mv);
    
    [ustar, vstar] = checkOutlet(bounds, ustar, vstar);
    
    figure(1);
    imagesc(ustar)
    figure(2);
    imagesc(vstar)
    figure(3);
    imagesc(pstar)

    
end
end