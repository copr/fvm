function [Mu, vectorU] = generateMomentumEqsU(pstar, ustar, vstar, bounds, ro, gama, Su, Sp, deltaX, deltaY, alfa, uold)
%generuje rovnice pro u
[nx, ny] = size(ustar);
unx = nx-2;
uny = ny-2;
[Mu, vectorU] = createMandVector(unx, uny);
for i=1:uny
    for j=1:unx
        obj = j+1;
        obi = i+1;
        Spom = Sp(obj,obi);
        Suom = Su(obj,obi);
        index = (i-1)*unx + j;
        
        um = ustar(obj, obi); 
        ul = ustar(obj, obi-1);
        ur = ustar(obj, obi+1);
        
        vrb = vstar(obj-1, obi+1);
        vlb = vstar(obj-1, obi);       
        vrt = vstar(obj, obi+1);
        vlt = vstar(obj, obi);
        
        Fw = (ro*um + ro*ul)/2;
        Fe = (ro*ur + ro*um)/2;
        Fs = (ro*vrb + ro*vlb)/2;
        Fn = (ro*vrt + ro*vlt)/2;
        Dw = gama/deltaX;
        De = gama/deltaX;
        Ds = gama/deltaY;
        Dn = gama/deltaY;
        
%         if j == unx
%             Spom
%         end

        [ae, aw, an, as, be, bw, bn, bs, Spom] = hybrid(index, obj, obi, Fe, Fw, Fn, Fs, ...
            De, Dw, Dn, Ds, Suom, Spom, deltaX, deltaY, um, vrb, bounds.u, unx, uny, 1/2, ustar); % zatim to asi nefachci pro outlet

        ap = as + an + ae + aw - Spom;

        Source = Suom + (pstar(obj, obi) - pstar(obj, obi+1))*deltaY + be + bw + bn + bs + (1-alfa)*(ap/alfa)*uold(obj,obi);
        line = assign(index, ap/alfa, an, as, ae, aw, unx, uny);
        Mu(index,1:end) = line;
        vectorU(index) = Source;
    end
end
end
