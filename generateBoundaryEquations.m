function [Mout, vectorOut] = generateBoundaryEquations(bounds, Min, vectorIn, nx, ny, allF, allD)
% Vygeneruje Matici a vektor pravych stran pro kontrolni objemy  ktere
% JSOU na okrajich

Mout = Min;
vectorOut = vectorIn;

for j=1:nx % to by chtelo prepsat at je to bez foru a bez podminky
    for i=1:ny
        index = (i-1)*nx + j; 
        
        Fe = allF(index, 1); Fw = allF(index, 2);
        Fn = allF(index, 3); Fs = allF(index, 4);
        
        De = allD(index, 1); Dw = allD(index, 2);
        Dn = allD(index, 3); Ds = allD(index, 4);
        
        ae = max3(-Fe, De - Fe/2, 0); % podle knizky strana 124
        aw = max3( Fw, Dw + Fw/2, 0); % kapitola 5.7.2
        an = max3( Fs, Ds + Fs/2, 0); % je tohle hybridni diferencovani
        as = max3(-Fn, Dn - Fn/2, 0); % chtel jsem to obecneji ale asi to nejde tak lehce
        ap = ae + aw + an + as;
        
        
        if (i == 1 || i == ny || j == 1 || j == nx) 
            index = (i-1)*nx + j; 
            
            if i == 1 % zapadni kraj
                if bounds.w_is_d % jestli je dirichlet na zapade
                    Mout(index, index) = 1;
                    vectorOut(index) = bounds.w;
                else % jestli je na zapade neumann
%                     
%                     an = 0;
%                     as = 0;
%                     aw = 0;
                    
                    line = assign(index, ap, an, as, ae, aw, nx, ny);
                    Mout(index,1:end) = line;
                    vectorOut(index) = 0;
                end
            end
            
            if i == ny % vychodni kraj
                if bounds.e_is_d % jestli je dirichlet na vychode
                    Mout(index, index) = 1;
                    vectorOut(index) = bounds.e;
                else % jestli je na vychode neumann
                    
                    an = 0;
                    as = 0;
                    ae = 0;
                    
                    line = assign(index, ap, an, as, ae, aw, nx, ny);
                    Mout(index,1:end) = line;
                    vectorOut(index) = bounds.e;
                end
            end
            
            if j == 1 % jizni kraj
                if bounds.s_is_d % jestli je dirichlet na jihu
                    Mout(index, index) = 1;
                    vectorOut(index) = bounds.s;
                else % jestli je na jihode neumann
                    
                    ae = 0;
                    as = 0;
                    aw = 0;
                    
                    line = assign(index, ap, an, as, ae, aw, nx, ny);
                    Mout(index,1:end) = line;
                    vectorOut(index) = bounds.s;
                end
            end
            
            if j == nx % zapadni kraj
                if bounds.n_is_d % jestli je dirichlet na severu
                    Mout(index, index) = 1;
                    vectorOut(index) = bounds.n;
                else % jestli je na severu neumann

                    
                    an = 0;
                    ae = 0;
                    aw = 0;
                    
                    line = assign(index, ap, an, as, ae, aw, nx, ny);
                    Mout(index,1:end) = line;
                    vectorOut(index) = bounds.n;
                end
            end
            
            if (i == 1 && j == 1 || i == 1 && j == nx || ...
                    i == ny && j == 1 || i == ny && j == nx) %hnus
                Mout(index, index) = 1; %rohy
                vectorOut(index) = 0;
            end
        end
    end
end

end

