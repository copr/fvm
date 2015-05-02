function [Mp, vectorP] = generetaPresureCorrectEqs(pstar, ustar, vstar, bounds, ro, gama, Su, Sp, deltaX, deltaY, Mu, Mv)
%generuje rovnice pro tlakove korecke
[unx, uny] = size(ustar);
[vnx, vny] = size(vstar);
[nx, ny] = size(pstar);
unx = unx - 2;
uny = uny - 2;
vnx = vnx - 2;
vny = vny - 2;
pnx = nx - 2;
pny = ny - 2;
n = nx*ny;
[Mp, vectorP] = createMandVector(pnx, pny);
for i=1:pny
    for j=1:pnx
        Spom = Sp;
        index = (i-1)*pnx + j;
        
        obj = j+1;
        obi = i+1;
        
%         
%                 ul = ustar(obj, obi-1);
%                 ind = (i-2)*unx + j;
%                 aw = ro*(alfa*(deltaY^2)/Mu(ind, ind));%(index-1, index-1));
%         
%                 ur = ustar(obj, obi);
%                 ind = (i-1)*unx + j;
%                 ae = ro*(alfa*(deltaY^2)/Mu(ind,ind));%(index,index));
%         
%                 vt = vstar(obj, obi);
%                 ind = (i-1)*vnx + j;
%                 an = ro*(alfa*(deltaX^2)/Mv(ind, ind));%(index-(i-1), index-(i-1)));
%         
%                 vb = vstar(obj-1, obi);
%                 ind = (i-1)*vnx + j -1;
%                 as = ro*(alfa*(deltaX^2)/Mv(ind,ind));%(index-1-(i-1), index-1-(i-1)));
        
                
        if i-1 < 1
            ul = ustar(obj, obi-1);
            aw = 0;
        else
            ul = ustar(obj, obi-1);
            ind = (i-2)*unx + j;
            aw = ro*((deltaY^2)/Mu(ind, ind));%(index-1, index-1));
        end
        if i > uny
            ur = ustar(obj, obi);
            ae = 0;
        else
            ur = ustar(obj, obi);
            ind = (i-1)*unx + j;

            ae = ro*((deltaY^2)/Mu(ind,ind));%(index,index));
        end
        if j > vnx
            vt = vstar(obj,obi);
            an = 0;
        else
            vt = vstar(obj, obi);
            ind = (i-1)*vnx + j;
            an = ro*((deltaX^2)/Mv(ind, ind));%(index-(i-1), index-(i-1)));
        end
        if j-1 < 1
            vb = vstar(obj-1, obi);
            as =  0;
        else
            vb = vstar(obj-1, obi);
            ind = (i-1)*vnx + j -1;
            as = ro*((deltaX^2)/Mv(ind,ind));%(index-1-(i-1), index-1-(i-1)));
       end
        
        Source = ro*ul*deltaY - ro*ur*deltaY + ro*vb*deltaX - ro*vt*deltaX;
%         sources(obj, obi) = Source;
        ap = as + an + ae + aw;
        line = assign(index, ap, an, as, ae, aw, pnx, pny);
        Mp(index,1:end) = line;
        vectorP(index) = Source;
    end
end


end