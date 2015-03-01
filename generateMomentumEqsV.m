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
        Spom = Sp(obj,obi);
        Suom = Su(obj,obi);
        index = (i-1)*vnx + j;
        
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

        [ae, aw, an, as, be, bw, bn, bs, Spom] = hybrid(index, obj, obi, Fe, Fw, Fn, Fs, ...
            De, Dw, Dn, Ds, Suom, Spom, deltaX, deltaY, urb, vm, bounds.v, vnx, vny, 1/2, vstar);% zatim to asi nefachci pro outlet
        ap = as + an + ae + aw - Spom;
        Source = Suom + (pstar(obj, obi) - pstar(obj+1, obi))*deltaX + be + bw + bn + bs + (1-alfa)*(ap/alfa)*vold(obj,obi);
        line = assign(index, ap/alfa, an, as, ae, aw, vnx, vny);
        Mv(index,1:end) = line;
        vectorV(index) = Source;
    end
end
end