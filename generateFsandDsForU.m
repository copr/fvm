function [allF, allD] = generateFsandDsForU(u, v, ro, gama, deltaX, deltaY)
[unx, uny] = size(u);
[vnx, vny] = size(v);
n = unx*uny;
allF = zeros(n, 4);
allD = zeros(n, 4);

for j=1:unx
    for i=1:uny
        index = (i-1)*unx + j;
        
%         um = u(j, i);
%         ul = u(j, i-1);
%         ur = u(j, i+1);
%         vlb = v(j-1, i);
%         vrt = v(j, i+1);
%         vrb = v(j-1, i+1);
%         vlt = v(j, i);
        
% kdyz nebudu pouzviat von neumanna tak to takhle muzu nechat a u simplu
% bych ho nemel ani potrebovat
        um = u(j, i);
        if i-1 < 1
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
        
        if i+1 > vny || j-1 < vnx
            vrb = 0;
        else
            vrb = v(j-1, i+1);
        end
            
        if j > vnx || i > vny
            vlt = 0;
        else
            vlt = v(j, i);
        end
        
        Fw = (ro*um + ro*ul)/2;
        Fe = (ro*ur + ro*um)/2;
        Fs = (ro*vrb + ro*vlb)/2;
        Fn = (ro*vrt + ro*vlt)/2;
        Dw = gama/deltaX;
        De = gama/deltaX;
        Ds = gama/deltaY;
        Dn = gama/deltaY;
        
        allF(index, 1) = Fe; allF(index, 2) = Fw;
        allF(index, 3) = Fn; allF(index, 4) = Fs;
        
        allD(index, 1) = De; allD(index, 2) = Dw;
        allD(index, 3) = Dn; allD(index, 4) = Ds;
    end
end

end