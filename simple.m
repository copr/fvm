function [ustar, vstar, pstar] = simple(nx, ny, bounds, Su, Sp, Lx, Ly, gama, ro, my_ep)
deltaX = Lx/nx;
deltaY = Ly/ny;

[ustar, vstar, pstar] = initUVPstar(nx, ny, bounds);
[unx, uny] = size(ustar);
[vnx, vny] = size(vstar);
[pnx, pny] = size(pstar);

Mu = sparse(unx*uny, unx*uny);
vectorU = zeros(unx*uny, 1);
Mv = sparse(vnx*vny, vnx*vny);
vectorV = zeros(vnx*vny, 1);

vold = zeros(vnx, vny);
uold = zeros(unx, uny);

alfaU = 0.8;
alfaV = alfaU;
alfaP = 0.1;

SU = zeros(unx, uny);
SV = zeros(vnx, vny);

SUp = zeros(unx, uny);
SVp = zeros(vnx, vny);

sources = ones(pnx, pny);

it = 0;
while it < 1000 && ~convergence(sources(2:end-1,2:end-1), my_ep)
    it = it+1
    %  [ustar, vstar] = checkOutlet(bounds, ustar, vstar);
    SU = zeros(unx, uny); SV = zeros(vnx, vny); SUp = zeros(unx, uny); SVp = zeros(vnx, vny);
    
    [SUp, SVp, SU, SV] = calcSourceTerms(bounds, SUp, SVp, SU, SV, deltaX, deltaY, gama);
    
    
    SU = calcPsourcesForU(SU, pstar, unx, uny, deltaX, deltaY);
    SV = calcPsourcesForV(SV, pstar, vnx, vny, deltaX, deltaY);
    
    [FsForU, DsForU] = generateFsandDsForU(ustar, vstar, ro, gama, deltaX, deltaY);
    [FsForV, DsForV] = generateFsandDsForV(ustar, vstar, ro, gama, deltaX, deltaY);
    
    [Mu, vectorU] = generateNonBoundaryEquations(SU, SUp, FsForU, DsForU, Mu, vectorU, unx, uny);
    [Mu, vectorU] = relaxace(Mu, vectorU, alfaU, unx, uny, uold);
    [Mu, vectorU] = generateBoundaryEquations(bounds.u, Mu, vectorU, unx, uny, FsForU, DsForU);
    
    [Mv, vectorV] = generateNonBoundaryEquations(SV, SVp, FsForV, DsForV, Mv, vectorV, vnx, vny);
    [Mv, vectorV] = relaxace(Mv, vectorV, alfaV, vnx, vny, vold);
    [Mv, vectorV] = generateBoundaryEquations(bounds.v, Mv, vectorV, vnx, vny, FsForV, DsForV);
    
    uold = ustar;
    vold = vstar;
    %spocitaniU
    ustar = Mu\vectorU;
    ustar = reshape(ustar, unx, uny);
    %spocitaniV
    vstar = Mv\vectorV;
    vstar = reshape(vstar, vnx, vny);

    [Mp, vectorP, sources] = generetaPresureCorrectEqs(pstar, ustar, vstar, bounds, ro, gama, Su, Sp, deltaX, deltaY, Mu, Mv, sources, alfaU);
    pcomma = pcg_chol(Mp, vectorP, my_ep);
%     Mp(1, :) = zeros(1, length(Mp(1,:)));
%     Mp(1,1) = 1;
%     vectorP(1) = 0; %upevneni tlaku
%     pcomma = Mp\vectorP; 
    pcomma = reshape(pcomma, pnx, pny);
       
    pstar = correctP(pcomma, pstar, alfaP);
    ustar = correctU(pcomma, ustar, deltaY, Mu);
    vstar = correctV(pcomma, vstar, deltaX, Mv);
    
%         vykreslovaciFce = @(x) mesh(x);
%     
%     
%         figure(1);
%     vykreslovaciFce(ustar);
%     figure(2);
%     vykreslovaciFce(vstar);
%     figure(3);
%     vykreslovaciFce(pstar);
%     waitforbuttonpress;
    
end

end