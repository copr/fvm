function [allF, allD] = generateFsandDsForV(u, v, ro, gama, deltaX, deltaY)
%vygeneruje vsechny koeficienty F a D pro V-rovnice.
[~, uny] = size(u);
[vnx, vny] = size(v);
n = vnx*vny;
allF = zeros(n, 4);
allD = zeros(n, 4);
for j=1:vnx
    for i=1:vny
        index = (i-1)*vnx + j;
        
        vm = v(j, i);
        if j-1 < 1
            vb = 0;
        else
            vb = v(j-1, i);
        end
        
        if j+1 > vnx
            vt = 0;
        else
            vt = v(j+1, i);
        end
        
        if i-1 < 1
            ulb = 0;
        else
            ulb = u(j, i-1);
        end
        
        if i-1 < 1
            ult = 0;
        else
            ult = u(j+1, i-1);
        end
        
        if i > uny
            urb = 0;
        else
            urb = u(j, i);
        end
        
        if i > uny
            urt = 0;
        else
            urt = u(j+1, i);
        end
        
        Fw = deltaY*(ro*ult + ro*ulb)/2;
        Fe = deltaY*(ro*urt + ro*urb)/2;
        Fs = deltaX*(ro*vb + ro*vm)/2;
        Fn = deltaX*(ro*vm + ro*vt)/2;
        Dw = deltaY*gama/deltaX;
        De = deltaY*gama/deltaX;
        Ds = deltaX*gama/deltaY;
        Dn = deltaX*gama/deltaY;
        
        allF(index, 1) = Fe; allF(index, 2) = Fw;
        allF(index, 3) = Fn; allF(index, 4) = Fs;
        
        allD(index, 1) = De; allD(index, 2) = Dw;
        allD(index, 3) = Dn; allD(index, 4) = Ds;
    end
end
end

%         vm = v(j, i);
%         vb = v(j-1, i);
%         vt = v(j+1, i);
%         ulb = u(j, i-1);
%         ult = u(j+1, i-1);
%         urb = u(j, i);
%         urt = u(j+1, i);
         
        
% kdyz nebudu pouzviat von neumanna tak to takhle muzu nechat a u simplu
% bych ho nemel ani potrebovat
%           vm = v(j, i);        
%         if j-1 < 1
%             vb = 0;
%         else
%             vb = v(j-1, i);
%         end
%         
%         if j+1 > vnx
%             vt = 0;
%         else
%             vt = v(j+1, i);
%         end
%         
%         if j > unx || i-1 < 1
%             ulb = 0;
%         else
%             ulb = u(j, i-1);
%         end
%         
%         if j+1 > unx || i-1 < 1
%             ult = 0;
%         else
%             ult = u(j+1, i-1);
%         end
%         
%         if j > unx || i > uny
%             urb = 0;
%         else
%             urb = u(j, i);
%         end
%         
%         if j+1 > unx || i > uny
%             urt = 0;
%         else
%             urt = u(j+1, i);
%         end