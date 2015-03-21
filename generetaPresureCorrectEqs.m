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
                aw = ro*alfa*deltaY*d;%(index-1, index-1));
            end
            if i == ny-1
                ur = ustar(j, i);% pro ted
                ae = 0;
            else
                ur = ustar(j, i);
                ind = (i-1)*unx + j;
                d = deltaY/Mu(ind, ind);
                ae = ro*alfa*deltaY*d;%(index,index));
            end
            if j == nx-1
                vt = vstar(j,i);
                an = 0;
            else
                vt = vstar(j, i);
                ind = (i-1)*vnx + j;
                d = deltaX/Mv(ind, ind);
                an = ro*alfa*deltaX*d;%(index-(i-1), index-(i-1)));
            end
            if j == 2
                vb = vstar(j-1, i);
                as =  0;
            else
                vb = vstar(j-1, i);
                ind = (i-1)*vnx + j -1;
                d = deltaX/Mv(ind, ind);
                as = ro*alfa*deltaX*d;%(index-1-(i-1), index-1-(i-1)));
            end
            
% %             
%             ul = ustar(j, i-1);
%             ind = (i-2)*unx + j;
%             if Mu(ind, ind) == 1
%                 aw = 0;
%             else
%                 aw = ro*(alfa*(deltaY^2)/Mu(ind, ind));%(index-1, index-1));
%             end
%                         
%             ur = ustar(j, i);
%             ind = (i-1)*unx + j;
%             if Mu(ind, ind) == 1
%                 ae = 0;
%             else
%                 ae = ro*(alfa*(deltaY^2)/Mu(ind,ind));%(index,index));
%             end
%                         
%             vt = vstar(j, i);
%             ind = (i-1)*vnx + j;
%             if Mv(ind, ind) == 1
%                 an = 0;
%             else
%                 an = ro*(alfa*(deltaX^2)/Mv(ind, ind));%(index-(i-1), index-(i-1)));
%             end
%                         
%             vb = vstar(j-1, i);
%             ind = (i-1)*vnx + j -1;
%             if Mv(ind, ind) == 1
%                 as = 0;
%             else
%                 as = ro*(alfa*(deltaX^2)/Mv(ind,ind));%(index-1-(i-1), index-1-(i-1)));
%             end
%  

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

            %
            
            %             if i-1 < 1
%                 ul = ustar(j, i-1);
%                 aw = 0;
%             else
%                 ul = ustar(j, i-1);
%                 ind = (i-2)*unx + j;
%                 aw = ro*(alfa*(deltaY^2)/Mu(ind, ind));%(index-1, index-1));
%             end
%             if i > uny
%                 ur = ustar(j, i);
%                 ae = 0;
%             else
%                 ur = ustar(j, i);
%                 ind = (i-1)*unx + j;
%                 
%                 ae = ro*(alfa*(deltaY^2)/Mu(ind,ind));%(index,index));
%             end
%             if j > vnx
%                 vt = vstar(j,i);
%                 an = 0;
%             else
%                 vt = vstar(j, i);
%                 ind = (i-1)*vnx + j;
%                 an = ro*(alfa*(deltaX^2)/Mv(ind, ind));%(index-(i-1), index-(i-1)));
%             end
%             if j-1 < 1
%                 vb = vstar(j-1, i);
%                 as =  0;
%             else
%                 vb = vstar(j-1, i);
%                 ind = (i-1)*vnx + j -1;
%                 as = ro*(alfa*(deltaX^2)/Mv(ind,ind));%(index-1-(i-1), index-1-(i-1)));
%             end
            

            