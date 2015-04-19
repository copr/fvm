function [Mp, vectorP, sources] = generetaPresureCorrectEqs(pstar, ustar, vstar, ro, deltaX, deltaY, Mu, Mv, sources)
%generuje rovnice pro tlakove korecke
[unx, ~] = size(ustar);
[vnx, ~] = size(vstar);
[nx, ny] = size(pstar);
[Mp, vectorP] = createMandVector(nx, ny);
for i=1:ny
    for j=1:nx
        index = (i-1)*nx + j;
        
        if i == 1
            ul = ustar(j+1, i);
            aw = 0;
        else
            ul = ustar(j+1, i);
            ind = (i-1)*unx + (j+1);
            d = deltaY/Mu(ind, ind);
            aw = ro*deltaY*d;
        end
        if i == ny
            ur = ustar(j+1, i+1);
            ae = 0;
        else
            ur = ustar(j+1, i+1);
            ind = (i)*unx + (j+1);
            d = deltaY/Mu(ind, ind);
            ae = ro*deltaY*d;
        end
        if j == nx
            vt = vstar(j+1,i);
            an = 0;
        else
            vt = vstar(j+1, i);
            ind = (i-1)*vnx + (j+1);
            d = deltaX/Mv(ind, ind);
            an = ro*deltaX*d;
        end
        if j == 1
            vb = vstar(j, i);
            as =  0;
        else
            vb = vstar(j, i);
            ind = (i-1)*vnx + j;
            d = deltaX/Mv(ind, ind);
            as = ro*deltaX*d;
        end
       

        Source = ro*ul*deltaY - ro*ur*deltaY + ro*vb*deltaX - ro*vt*deltaX;

        sources(j, i) = Source;
        ap = as + an + ae + aw;

        line = assign(index, ap, an, as, ae, aw, nx, ny);
        Mp(index,1:end) = line;
        vectorP(index) = Source;
    end
end


end

            

            