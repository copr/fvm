function [ustar, vstar, pstar] = simpleAlgorithm(nx, ny, bounds, Su, Sp, X, Y, gama, ro, my_ep)
%hlavni funkce pro spusteni SIMPLu
deltaX = X/nx;
deltaY = Y/ny;
[ustar, vstar, pstar] = initUVPstar(nx, ny, bounds);
USp = zeros(size(ustar));
VSp = zeros(size(vstar));
USu = zeros(size(ustar));
VSu = zeros(size(vstar));
[USp, VSp, USu, VSu] = calcSourceTerms(bounds, USp, VSp, USu, VSu, deltaX, deltaY, gama);
% USp = USp .* deltaX*deltaY;
% USu = USu .* deltaX*deltaY;
% VSp = VSp .* deltaX*deltaY;
% VSu = VSu .* deltaX*deltaY;
[unx, uny] = size(ustar);
[vnx, vny] = size(vstar);
[pnx, pny] = size(pstar);
vectorP = ones(pnx*pny, 1);
vold = zeros(vnx, vny);
uold = zeros(unx, uny);
alfaU = 0.7; %relaxace rychlosti
alfaV = 0.7;
alfaP = 0.3; %relaxace tlaku
it = 0;
while it < 1000 && ~convergence(vectorP, my_ep)
    [ustar, vstar] = checkOutlet(bounds, ustar, vstar);
    it = it + 1
    [Mu, vectorU] = generateMomentumEqsU(pstar, ustar, vstar, bounds, ro, gama, USu, USp, deltaX, deltaY, alfaU, uold);
    [Mv, vectorV] = generateMomentumEqsV(pstar, ustar, vstar, bounds, ro, gama, VSu, VSp, deltaX, deltaY, alfaV, vold);
    
%     full(Mu)
    
    uold = ustar;
    vold = vstar;

    ustarIn = Mu\vectorU;
    vstarIn = Mv\vectorV;
%     ustarIn = pcg_chol(Mu, vectorU, my_ep);
%     vstarIn = pcg_chol(Mv, vectorV, my_ep);
%     

    ustarIn = reshape(ustarIn, unx-2, uny-2);
    vstarIn = reshape(vstarIn, vnx-2, vny-2);
    
    ustar(2:end-1, 2:end-1) = ustarIn;
    vstar(2:end-1, 2:end-1) = vstarIn;
    
    
    [Mp, vectorP] = generetaPresureCorrectEqs(pstar, ustar, vstar, bounds, ro, gama, Su, Sp, deltaX, deltaY, Mu, Mv);
%     
    Mp(1, :) = zeros(1, length(Mp(1,:)));
    Mp(1,1) = 1;
    vectorP(1) = 0; %upevneni tlaku
    pcomma = Mp\vectorP; 
    
%     pcomma = pcg_chol(Mp, vectorP, my_ep);
    pcomma = reshape(pcomma, pnx-2, pny-2);
       
    pstar = correctP(pcomma, pstar, alfaP);
    ustar = correctU(pcomma, ustar, deltaY, Mu);
    vstar = correctV(pcomma, vstar, deltaX, Mv);
   
end
ustar = uold;
vstar = vold;
end