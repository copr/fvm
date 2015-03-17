function [Mout, vectorOut] = generateBoundaryEquations(bounds, Min, vectorIn, nx, ny, allF, allD, vals)
% Vygeneruje Matici a vektor pravych stran pro kontrolni objemy  ktere
% JSOU na okrajich

%Von Neumanny vytahnout do vedlejsi funkce
Mout = Min;
vectorOut = vectorIn;


for j=1:nx
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
        
%         if (i == 1 && j == 1 || i == 1 && j == nx || ...
%                 i == ny && j == 1 || i == ny && j == nx) %hnus
%             Mout(index, index) = 1; %rohy
%             vectorOut(index) = 0;
%             continue;
%         end
        
        if (i == 1 && j == 1)
            ap = an + ae;
            line = assign(index, ap, an, 0, ae, 0, nx, ny);
            S = 0;
            Mout(index,1:end) = line;
            vectorOut(index) = S;
            continue;
        end
        
        if (i == 1 && j == nx)
            ap = as + ae;
            line = assign(index, ap, 0, as, ae, 0, nx, ny);
            S = 0;
            Mout(index,1:end) = line;
            vectorOut(index) = S;
            continue;
        end
        
        if (i == ny && j == 1 )
            ap = an + aw;
            line = assign(index, ap, an, aw, 0, 0, nx, ny);
            S = 0;
            Mout(index,1:end) = line;
            vectorOut(index) = S;
            continue;
        end
        
        if (i == ny && j == nx)
            ap = as + aw;
            line = assign(index, ap, 0, as, 0, aw, nx, ny);
            S = 0;
            Mout(index,1:end) = line;
            vectorOut(index) = S;
            continue;
        end
        
        
        if (i == 1 || i == ny || j == 1 || j == nx) 
            index = (i-1)*nx + j; 
            
            if i == 1 % zapadni kraj
                if bounds.w_is_d % jestli je dirichlet na zapade
                    line = assign(index, 1, 0, 0, 0, 0, nx, ny);
                    S = vals(j, i);
                else % jestli je na zapade neumann
                    ap = ae + an + as;
                    line = assign(index, ap, an, as, ae, 0, nx, ny);
                    S = bounds.w;
                end
            end
            
            if i == ny % vychodni kraj
                if bounds.e_is_d % jestli je dirichlet na vychode
                    line = assign(index, 1, 0, 0, 0, 0, nx, ny);
                    S = vals(j, i);
                else % jestli je na vychode neumann
                    ap = aw + an + as;
                    line = assign(index, ap, an, as, 0, aw, nx, ny);
                    S = bounds.e;
                end
            end
            
            if j == 1 % jizni kraj
                if bounds.s_is_d % jestli je dirichlet na jihu
                    line = assign(index, 1, 0, 0, 0, 0, nx, ny);
                    S = vals(j, i);
                else % jestli je na jihode neumann
                    ap = aw + an + ae;
                    line = assign(index, ap, an, 0, ae, aw, nx, ny);
                    S = bounds.s;
                end
            end
            
            if j == nx % severni kraj
                if bounds.n_is_d % jestli je dirichlet na severu
                    line = assign(index, 1, 0, 0, 0, 0, nx, ny);
                    S = vals(j, i);
                else % jestli je na severu neumann
                    ap = aw + ae + as;               
                    line = assign(index, ap, 0, as, ae, aw, nx, ny);
                    S = bounds.n;
                end
            end
            Mout(index,1:end) = line;
            vectorOut(index) = S;
        end
    end
end

end

