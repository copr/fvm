function [Mv, vectorV] = generateMomentumEqsV(pstar, ustar, vstar, bounds, ro, gama, Su, Sp, deltaX, deltaY, alfa, vold)
%generuje rovnice pro v
[vnx, vny] = size(vstar);
[Mv, vectorV] = createMandVector(vnx-2, vny-2);
index = 1;
for i=2:vny-1
    for j=2:vnx-1
        obj = j;
        obi = i;
        Spom = Sp(obj,obi);
        Suom = Su(obj,obi);
        
        vm = vstar(obj, obi);        
        vb = vstar(obj-1, obi);       
        vt = vstar(obj+1, obi);   
        
        ulb = ustar(obj, obi-1);
        ult = ustar(obj+1, obi-1);     
        urb = ustar(obj, obi);
        urt = ustar(obj+1, obi);
        
        
        Fw = deltaY*(ro*ult + ro*ulb)/2;
        Fe = deltaY*(ro*urt + ro*urb)/2;
        Fs = deltaX*(ro*vb + ro*vm)/2;
        Fn = deltaX*(ro*vm + ro*vt)/2;
        Dw = deltaY*gama/deltaX;
        De = deltaY*gama/deltaX;
        Ds = deltaX*gama/deltaY;
        Dn = deltaX*gama/deltaY;
        
        
        ae = max([-Fe, De - Fe/2, 0]); % podle knizky strana 124
        aw = max([ Fw, Dw + Fw/2, 0]); % kapitola 5.7.2
        an = max([-Fn, Dn - Fn/2, 0]); % je tohle hybridni diferencovani
        as = max([ Fs, Ds + Fs/2, 0]); % chtel jsem to obecneji ale asi to nejde tak lehce
        Spom = Sp(j,i);
        
        be = 0; bw = 0; bn = 0; bs = 0;
        
        if i == 2
            Dw = 2*deltaY*gama/deltaX;
            aw = max([ Fw, Dw + Fw/2, 0]);
            bw = aw*vstar(j, i-1);
            Spom = Spom - aw;
            aw = 0;
        end
        if i == vny-1
            De = 2*deltaY*gama/deltaX;
            ae = max([-Fe, De - Fe/2, 0]); 
            be = ae*vstar(j, i+1);
            Spom = Spom - ae;
            ae = 0;
        end
        if j == 2
            bs = as*vb;
            Spom = Spom - as;
            as = 0;
        end
        if j == vnx-1
            bn = an*vt;
            Spom = Spom - an;
            an = 0;
        end
        
% 
%         [ae, aw, an, as, be, bw, bn, bs, Spom] = hybrid(index, obj, obi, Fe, Fw, Fn, Fs, ...
%             De, Dw, Dn, Ds, Suom, Spom, deltaX, deltaY, urb, vm, bounds.v, vnx, vny, 1/2, vstar);% zatim to asi nefachci pro outlet
        ap = as + an + ae + aw - Spom;
        Source = Suom + (pstar(obj, obi) - pstar(obj+1, obi))*deltaX + be + bw + bn + bs + (1-alfa)*(ap/alfa)*vold(obj,obi);

        line = assign(index, ap/alfa, an, as, ae, aw, vnx-2, vny-2);
        Mv(index,1:end) = line;
        vectorV(index) = Source;
        index = index+1;
    end
end
end