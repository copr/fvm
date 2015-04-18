function [allF, allD] = generateFsandDsForU(u, v, ro, gama, deltaX, deltaY)
%vygeneruje vsechny koeficienty F a D pro U-rovnice.
[unx, uny] = size(u);
[vnx, vny] = size(v);
n = unx*uny;
allF = zeros(n, 4);
allD = zeros(n, 4);
for j=1:unx
    for i=1:uny
        index = (i-1)*unx + j;
        
        um = u(j, i);
        if i <= 1
            ul = 0;
        else
            ul = u(j, i-1);
        end
        
        if i+1 > uny
            ur = 0;
        else
            ur = u(j, i+1);
        end
        
        if j-1 < 1 || i > vny
            vlb = 0;
        else
            vlb = v(j-1, i);
        end
        
        if i+1 > vny || j > vnx
            vrt = 0;
        else
            vrt = v(j, i+1);
        end
        
        if i+1 > vny || j-1 < 1
            vrb = 0;
        else
            vrb = v(j-1, i+1);
        end
            
        if j > vnx || i > vny
            vlt = 0;
        else
            vlt = v(j, i);
       end
        
        Fw = deltaY*(ro*um + ro*ul)/2;
        Fe = deltaY*(ro*ur + ro*um)/2;
        Fs = deltaX*(ro*vrb + ro*vlb)/2;
        Fn = deltaX*(ro*vrt + ro*vlt)/2;
        Dw = deltaY*gama/deltaX;
        De = deltaY*gama/deltaX;
        Ds = deltaX*gama/deltaY;
        Dn = deltaX*gama/deltaY;
        
        allF(index, 1) = Fe; allF(index, 2) = Fw;
        allF(index, 3) = Fn; allF(index, 4) = Fs;
        
        allD(index, 1) = De; allD(index, 2) = Dw;
        allD(index, 3) = Dn; allD(index, 4) = Ds;
%         u
%         v
%         waitforbuttonpress;
    end
end
end

%         um = u(j, i);
%         ul = u(j, i-1);
%         ur = u(j, i+1);
%         vlb = v(j-1, i);
%         vrt = v(j, i+1);
%         vrb = v(j-1, i+1);
%         vlt = v(j, i);

%         um = u(j, i);
%         if i-1 < 1
%             ul = 0;
%         else
%             ul = u(j, i-1);
%         end
%         
%         if i+1 > uny
%             ur = 0;
%         else
%             ur = u(j, i+1);
%         end
%         
%         if j-1 < 1 || i > vny
%             vlb = 0;
%         else
%             vlb = v(j-1, i);
%         end
%         
%         if i+1 > vny || j > vnx
%             vrt = 0;
%         else
%             vrt = v(j, i+1);
%         end
%         
%         if i+1 > vny || j-1 < 1
%             vrb = 0;
%         else
%             vrb = v(j-1, i+1);
%         end
%             
%         if j > vnx || i > vny
%             vlt = 0;
%         else
%             vlt = v(j, i);
%        end