function [Mout, vectorOut] = generateNonBoundaryEquations(Su, Sp, allF, allD, Min, vectorIn, nx, ny, Icko)
% Vygeneruje Matici a vektor pravych stran pro kontrolni objemy  ktere
% NEjsou na okrajich

Mout = Min;
vectorOut = vectorIn;
order = 1;
for i=1:ny
    for j=1:nx
        index = (i-1)*nx + j;
        Fe = allF(index, 1); Fw = allF(index, 2);
        Fn = allF(index, 3); Fs = allF(index, 4);
        
        De = allD(index, 1); Dw = allD(index, 2);
        Dn = allD(index, 3); Ds = allD(index, 4);
        
        if i == 1
            Fw = 0;
            Dw = 0;
        end
        if i == ny
            Fe = 0;
            De = 0;
        end
        if j == 1
            Fs = 0;
            Ds = 0;
        end
        if j == nx
            Fn = 0;
            Dn = 0;
        end
        
        ae = max([-Fe, De - Fe/2, 0]); % podle knizky strana 124
        aw = max([ Fw, Dw + Fw/2, 0]); % kapitola 5.7.2
        an = max([-Fn, Dn - Fn/2, 0]); % je tohle hybridni diferencovani
        as = max([ Fs, Ds + Fs/2, 0]);
        deltaF = Fe - Fw + Fn - Fs;
        %         if i == Icko
        %             ap = ae + aw + an + as;
        %             vectorOut(index) = 0;
        %         else
        vectorOut(order) = Su(j, i);
        ap = ae + aw + an + as - Sp(j,i) + deltaF;
        line = assign(index, ap, an, as, ae, aw, nx, ny);
        Mout(order, :) = line;
        order = order+1;
    end
end
end

