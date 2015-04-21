function [allF, allD] = generateFsandDsForU(u, v, ro, gama, deltaX, deltaY)
%vygeneruje vsechny koeficienty F a D pro U-rovnice.
[unx, uny] = size(u);
[vnx, ~] = size(v);
n = unx*uny;
allF = zeros(unx, uny);
allD = zeros(unx, uny);
for j=1:unx
    for i=1:uny
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
        
        if j-1 < 1
            vlb = 0;
        else
            vlb = v(j-1, i);
        end
        
        if j-1 < 1
            vrb = 0;
        else
            vrb = v(j-1, i+1);
        end
        
        
        if j > vnx
            vrt = 0;
        else
            vrt = v(j, i+1);
        end
        

        if j > vnx
            vlt = 0;
        else
            vlt = v(j, i);
        end
        
        Fw = deltaY*ro*(um + ul)/2;
        Fe = deltaY*ro*(ur + um)/2;
        Fs = deltaX*ro*(vrb + vlb)/2;
        Fn = deltaX*ro*(vrt + vlt)/2;
        Dw = deltaY*gama/deltaX;
        De = deltaY*gama/deltaX;
        Ds = deltaX*gama/deltaY;
        Dn = deltaX*gama/deltaY;
  
        allF(j, i, 1:4) = [Fe, Fw, Fn, Fs];
        allD(j, i, 1:4) = [De, Dw, Dn, Ds];
        
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