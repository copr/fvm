function [allF, allD] = generateFsandDsForV(u, v, ro, gama, deltaX, deltaY)
%vygeneruje vsechny koeficienty F a D pro V-rovnice.
[~, uny] = size(u);
[vnx, vny] = size(v);
n = vnx*vny;
allF = zeros(vnx, vny);
allD = zeros(vnx, vny);
for j=1:vnx
    for i=1:vny
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
        
        allF(j, i, 1:4) = [Fe, Fw, Fn, Fs];
        allD(j, i, 1:4) = [De, Dw, Dn, Ds];
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