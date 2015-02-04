function [ustar, vstar, pstar] = simpleAlgorithm(nx, ny, bounds, Su, Sp, X, Y, gama, ro, my_ep)
deltaX = X/nx;
deltaY = Y/ny;
[ustar, vstar, pstar] = initUVPstar(nx, ny, bounds);
[unx, uny] = size(ustar);
[vnx, vny] = size(vstar);
[pnx, pny] = size(pstar);
vold = zeros(vnx, vny);
uold = zeros(unx, uny);
sources = ones(pnx,pny);
alfaU = 0.8; %relaxace rychlosti
alfaP = 0.3; %relaxace tlaku
it = 0;
while it < 30 && ~convergence(sources(2:end-1,2:end-1), my_ep)
    it = it + 1;
    [Mu, vectorU] = generateMomentumEqsU(pstar, ustar, vstar, bounds, ro, gama, Su, Sp, deltaX, deltaY, alfaU, uold);
    [Mv, vectorV] = generateMomentumEqsV(pstar, ustar, vstar, bounds, ro, gama, Su, Sp, deltaX, deltaY, alfaU, vold);
    
    uold = ustar;
    vold = vstar;
%     
%     ustarIn = Mu\vectorU;
%     vstarIn = Mv\vectorV;
    ustarIn = pcg_chol(Mu, vectorU, my_ep);
    vstarIn = pcg_chol(Mv, vectorV, my_ep);


    ustarIn = reshape(ustarIn, unx-2, uny-2);
    vstarIn = reshape(vstarIn, vnx-2, vny-2);
    
    ustar(2:end-1, 2:end-1) = ustarIn;
    vstar(2:end-1, 2:end-1) = vstarIn;
    
    
    [Mp, vectorP, sources] = generetaPresureCorrectEqs(pstar, ustar, vstar, bounds, ro, gama, Su, Sp, deltaX, deltaY, Mu, Mv, sources, alfaU);

%     pcomma = Mp\vectorP; musel by se pouzit upevneni tlaku 
    pcomma = pcg_chol(Mp, vectorP, my_ep);
    pcomma = reshape(pcomma, pnx-2, pny-2);
       
    pstar = correctP(pcomma, pstar, alfaP);
    ustar = correctU(pcomma, ustar, deltaY, Mu);
    vstar = correctV(pcomma, vstar, deltaX, Mv);
    
   % waitforbuttonpress;
    
    %initUVPstar(nx, ny, bounds, zeros(unx,uny), zeros(vnx, vny), pstar)
end
it
ustar = uold;
vstar = vold;
end