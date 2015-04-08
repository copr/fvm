function [Mp, vectorP, sources] = generetaPresureCorrectEqs(pstar, ustar, vstar, bounds, ro, gama, Su, Sp, deltaX, deltaY, Mu, Mv, sources, alfa)
%generuje rovnice pro tlakove korecke
[unx, ~] = size(ustar);
[vnx, ~] = size(vstar);
[nx, ny] = size(pstar);
[Mp, vectorP] = createMandVector(nx, ny);
for i=1:ny
    for j=1:nx
        Spom = Sp;
        index = (i-1)*nx + j;
%         
%          if i >= 8 && i <= 13 && j >= 14 && j <= 20
%              Mp(index, index) = 1;
%              vectorP(index) = 0;
%              continue;
%          end
        
        if (i == 1 || j == 1 || i == ny || j == nx)
            Mp(index, index) = 1;
            vectorP(index) = 0;
        else
            
            if i == 2
                ul = ustar(j, i-1);
                aw = 0;
            else
                ul = ustar(j, i-1);
                ind = (i-2)*unx + j;
                d = deltaY/Mu(ind, ind);
                aw = ro*alfa*deltaY*d;
            end
            if i == ny-1
                ur = ustar(j, i);
                ae = 0;
            else
                ur = ustar(j, i);
                ind = (i-1)*unx + j;
                d = deltaY/Mu(ind, ind);
                ae = ro*alfa*deltaY*d;
            end
            if j == nx-1
                vt = vstar(j,i);
                an = 0;
            else
                vt = vstar(j, i);
                ind = (i-1)*vnx + j;
                d = deltaX/Mv(ind, ind);
                an = ro*alfa*deltaX*d;
            end
            if j == 2
                vb = vstar(j-1, i);
                as =  0;
            else
                vb = vstar(j-1, i);
                ind = (i-1)*vnx + j -1;
                d = deltaX/Mv(ind, ind);
                as = ro*alfa*deltaX*d;
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


end

            

            