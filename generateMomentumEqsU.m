function [Mu, vectorU] = generateMomentumEqsU(pstar, ustar, vstar, bounds, ro, gama, Su, Sp, deltaX, deltaY, alfa, uold)
%generuje rovnice pro u
[unx, uny] = size(ustar);
[Mu, vectorU] = createMandVector(unx-2, uny-2);
index = 1;
for i=2:uny-1
    for j=2:unx-1
        obj = j;
        obi = i;
        Spom = Sp(obj,obi);
        Suom = Su(obj,obi);

        um = ustar(obj, obi);
        ul = ustar(obj, obi-1);
        ur = ustar(obj, obi+1);
        
        vrb = vstar(obj-1, obi+1);
        vlb = vstar(obj-1, obi);
        vrt = vstar(obj, obi+1);
        vlt = vstar(obj, obi);
        
        Fw = deltaY*(ro*um + ro*ul)/2;
        Fe = deltaY*(ro*ur + ro*um)/2;
        Fs = deltaX*(ro*vrb + ro*vlb)/2;
        Fn = deltaX*(ro*vrt + ro*vlt)/2;
        Dw = deltaY*gama/deltaX;
        De = deltaY*gama/deltaX;
        Ds = deltaX*gama/deltaY;
        Dn = deltaX*gama/deltaY;
        
        %         if j == unx
        %             Spom
        %         end
        ae = max([-Fe, De - Fe/2, 0]); % podle knizky strana 124
        aw = max([ Fw, Dw + Fw/2, 0]); % kapitola 5.7.2
        an = max([-Fn, Dn - Fn/2, 0]); % je tohle hybridni diferencovani
        as = max([ Fs, Ds + Fs/2, 0]); % chtel jsem to obecneji ale asi to nejde tak lehce
        
        be = 0; bw = 0; bn = 0; bs = 0;
        
        if i == 2
            bw = aw*ul;
            Spom = Spom - aw;
            aw = 0;
        end
        if i == uny-1
            be = ae*ur;
            Spom = Spom - ae;
            ae = 0;
        end
        if j == 2
            Ds = 2*deltaX*gama/deltaY;
            as = max([ Fs, Ds + Fs/2, 0]);
            bs = as*ustar(j-1, i);
            Spom = Spom - as;
            as = 0;
        end
        if j == unx-1
            Dn = 2*deltaX*gama/deltaY;
            an = max([-Fn, Dn - Fn/2, 0]);
            bn = an*ustar(j+1, i);
            Spom = Spom - an;
            an = 0;
        end
        
        
        ap = ae + aw + an + as - Spom;
        
        %         [ae, aw, an, as, be, bw, bn, bs, Spom] = hybrid(index, obj, obi, Fe, Fw, Fn, Fs, ...
        %             De, Dw, Dn, Ds, Suom, Spom, deltaX, deltaY, um, vrb, bounds.u, unx, uny, 1/2, ustar); % zatim to asi nefachci pro outlet
        
        %         ap = as + an + ae + aw - Spom;
        
        Source = Suom + (pstar(obj, obi) - pstar(obj, obi+1))*deltaY + be + bw + bn + bs + (1-alfa)*(ap/alfa)*uold(obj,obi);

        line = assign(index, ap/alfa, an, as, ae, aw, unx-2, uny-2);
        Mu(index,1:end) = line;
        vectorU(index) = Source;
        index = index+1;
    end
end
end
