function [ustar, vstar, pstar] = simple(nx, ny, bounds, Su, Sp, Lx, Ly, gama, ro, my_ep, alfaU, alfaV, alfaP, maxIter)
%hlavni funkce pro spusteni SIMPLu
%okrajove podminky jsou zadany pomoci rovnic
%nx - pocet objemu na ose x, ny - pocet kontrolnich objemu na ose y,
%bounds - okrajove podminky, Su,Sp - zdroje, Lx,Ly - delka oblasti v x,y
%gama - difuzni koeficinent, ro - hustota, my_ep - pozadovana presnot
%alfa - relaxace jednotlivych vypoctu
%ustar - napocitane rychlosti ve smeru osy x, vstar - ve smeru y
%pstar - tlaakove pole
deltaX = Lx/nx;
deltaY = Ly/ny;

[ustar, vstar, pstar] = initUVPstar(nx, ny, bounds);
[unx, uny] = size(ustar);
[vnx, vny] = size(vstar);
[pnx, pny] = size(pstar);

% ustar(:,1) = 0;
% ustar(8:14, 1) = 0.01;
nu = unx*uny;
Mu = sparse(nu, nu);
vectorU = zeros(nu, 1);
Bu = sparse(2*(unx+uny-2), nu);
vectorBu = zeros(2*(unx+uny-2),1);
nv = vnx*vny;
Mv = sparse(nv, nv);
vectorV = zeros(nv, 1);
Bv = sparse(2*(vnx+vny-2), nv);
vectorBv = zeros(2*(vnx+vny-2),1);
vold = zeros(vnx, vny);
uold = zeros(unx, uny);
sources = ones(pnx, pny);

Muu = sparse(nu, nu);
Mvv = sparse(nv, nv);

it = 0;
while it < maxIter && ~convergence(sources, my_ep)
    it = it+1
    % ustar
    SU = zeros(unx, uny); SV = zeros(vnx, vny); SUp = zeros(unx, uny); SVp = zeros(vnx, vny);
    
    %spocita zdroje ktere vychazeji z toho ze na okrajich jsou zadane zdi
    [SUp, SVp, SU, SV] = calcSourceTermsArisingFromWalls(bounds, SUp, SVp, SU, SV, deltaX, deltaY, gama);
    
    
    %spocita zdroje, ktere vychazeji z hodnot tlaku
    SU = calcSourcesFromPressureForU(SU, pstar, unx, uny, deltaX, deltaY);
    SV = calcSourcesFromPressureForV(SV, pstar, vnx, vny, deltaX, deltaY);
    
    [FsForU, DsForU] = generateFsandDsForU(ustar, vstar, ro, gama, deltaX, deltaY); % generovani koeficientu pro vsechny rovnice
    [FsForV, DsForV] = generateFsandDsForV(ustar, vstar, ro, gama, deltaX, deltaY);
    
    [Mu, ~, resultU] = generateSeperateMatrices(SU, SUp, FsForU, DsForU, unx, uny, 2, 3, ustar, alfaU, uold);
    [Mv, ~, resultV] = generateSeperateMatrices(SV, SVp, FsForV, DsForV, vnx, vny, 3, 2, vstar, alfaV, vold);
    
    
    [Muu, ~] = generateNonBoundaryEquations(SU, SUp, FsForU, DsForU, Muu, vectorU, unx, uny, 0, 0); % vygeneruje matici pro u s rovnicemi pro vsechny neokrajove prvky
    [Muu, ~] = relax(Muu, vectorU, alfaU, unx, uny, uold); % relaxace je uprostred aby nezmenily uz okrajove rovnice

    [Mvv, ~] = generateNonBoundaryEquations(SV, SVp, FsForV, DsForV, Mvv, vectorV, vnx, vny, 0, 0); %to same jako predtim pro v
    [Mvv, ~] = relax(Mvv, vectorV, alfaV, vnx, vny, vold);

    uold = ustar;
    vold = vstar;
    ustar = resultU;
    vstar = resultV;
    
    [Mp, vectorP, sources] = generetaPresureCorrectEqs(pstar, ustar, vstar, ro, deltaX, deltaY, Muu, Mvv, sources); % vytvoreni rovnci tlakovych korekci
%     vectorP
    
    pcomma = pcg_chol(Mp, vectorP, my_ep);
    pcomma = reshape(pcomma, pnx, pny);
    

    %korekce
    pstar = correctP(pcomma, pstar, alfaP);
    ustar = correctU(pcomma, ustar, deltaY, Muu);
    vstar = correctV(pcomma, vstar, deltaX, Mvv);
    
%     waitforbuttonpress
    %   [ustar, vstar] = checkOutlet(bounds, ustar, vstar);
    

end
end