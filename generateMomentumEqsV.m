function [Mv, vectorV] = generateMomentumEqsV(pstar, ustar, vstar, bounds, ro, gama, Su, Sp, deltaX, deltaY, alfa, vold)
%generuje rovnice pro v
[nx, ny] = size(vstar);
vnx = nx-2;
vny = ny-2;
[Mv, vectorV] = createMandVector(vnx, vny);
for i=1:vny
    for j=1:vnx
        obj = j+1;
        obi = i+1;
        Spom = Sp;
        index = (i-1)*vnx + j;
        
        vm = vstar(obj, obi);        
        vb = vstar(obj-1, obi);       
        vt = vstar(obj+1, obi);   
        
        ulb = ustar(obj, obi-1);
        ult = ustar(obj+1, obi-1);     
        urb = ustar(obj, obi);
        urt = ustar(obj+1, obi);
        
        
        Fw = (ro*ult + ro*ulb)/2;
        Fe = (ro*urt + ro*urb)/2;
        Fs = (ro*vb + ro*vm)/2;
        Fn = (ro*vm + ro*vt)/2;
        Dw = gama/deltaX;
        De = gama/deltaX;
        Ds = gama/deltaY;
        Dn = gama/deltaY;

        [ae, aw, an, as, be, bw, bn, bs, Spom] = hybrid(index, obj, obi, Fe, Fw, Fn, Fs, ...
            De, Dw, Dn, Ds, Su, Spom, deltaX, deltaY, urb, vm, bounds.v, vnx, vny, 1, vstar);% zatim to asi nefachci pro outlet
        ap = as + an + ae + aw - Spom;
        Source = Su + (pstar(obj, obi) - pstar(obj+1, obi))*deltaX + be + bw + bn + bs + (1-alfa)*(ap/alfa)*vold(obj,obi);
        line = assign(index, ap/alfa, an, as, ae, aw, vnx, vny);
        Mv(index,1:end) = line;
        vectorV(index) = Source;
    end
end
end