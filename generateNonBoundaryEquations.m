function [Mout, vectorOut] = generateNonBoundaryEquations(Su, Sp, allF, allD, Min, vectorIn, nx, ny)
% Vygeneruje Matici a vektor pravych stran pro kontrolni objemy  ktere
% NEjsou na okrajich

Mout = Min;
vectorOut = vectorIn;
for j=2:nx-1
    for i=2:ny-1
        index = (i-1)*nx + j; 
        Fe = allF(index, 1); Fw = allF(index, 2);
        Fn = allF(index, 3); Fs = allF(index, 4);
        
        De = allD(index, 1); Dw = allD(index, 2);
        Dn = allD(index, 3); Ds = allD(index, 4);
        
        ae = max3(-Fe, De - Fe/2, 0); % podle knizky strana 124 
        aw = max3( Fw, Dw + Fw/2, 0); % kapitola 5.7.2
        an = max3(-Fn, Dn - Fn/2, 0); % je tohle hybridni diferencovani
        as = max3( Fs, Ds + Fs/2, 0); 
        deltaF = Fe - Fw + Fn - Fs;
        ap = ae + aw + an + as - Sp(j,i) + deltaF;
        
        line = assign(index, ap, an, as, ae, aw, nx, ny);
        Mout(index,1:end) = line;
        vectorOut(index) = Su(j,i);
    end
end

end

