function [Mout, vectorOut] = generateNonBoundaryEquations(Su, Sp, allF, allD, Min, vectorIn, NX, nx, ny ...
    , startI, endI, startJ, endJ)
% Vygeneruje Matici a vektor pravych stran pro kontrolni objemy  ktere
% NEjsou na okrajich

Mout = Min;
vectorOut = vectorIn;

for j=startJ:endJ
    for i=startI:endI

        index = (i-1)*NX + j;
        
        Fe = allF(index, 1); Fw = allF(index, 2);
        Fn = allF(index, 3); Fs = allF(index, 4);
        
        De = allD(index, 1); Dw = allD(index, 2);
        Dn = allD(index, 3); Ds = allD(index, 4);
        
        ae = max([-Fe, De - Fe/2, 0]); % podle knizky strana 124 
        aw = max([ Fw, Dw + Fw/2, 0]); % kapitola 5.7.2
        an = max([ Fs, Ds + Fs/2, 0]); % je tohle hybridni diferencovani
        as = max([-Fn, Dn - Fn/2, 0]); 

        ap = ae + aw + an + as - Sp(j,i);
        vectorOut(index) = Su(j, i);
        
        line = assign(index, ap, an, as, ae, aw, nx, ny);
        Mout(index,1:end) = line;
       
    end
end

end

