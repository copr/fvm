function [equation, rhs] = generateBoundaryEquation(i, j, bounds, nx, ny, allF, allD)
% Vygeneruje jednu rovnici pro kontrolni objemy  ktere
% JSOU na okrajich

equation = zeros(1, nx*ny);
rhs = 0;

index = (i-1)*nx + j;

Fe = allF(index, 1); Fw = allF(index, 2);
Fn = allF(index, 3); Fs = allF(index, 4);

De = allD(index, 1); Dw = allD(index, 2);
Dn = allD(index, 3); Ds = allD(index, 4);


if i == 1 % zapadni kraj
    if bounds.w_is_d % jestli je dirichlet na zapade
        equation(index) = 1;
        rhs = bounds.w;
    else % jestli je na zapade neumann
        ae = max3(-Fe, De - Fe/2, 0); % podle knizky strana 124
        aw = max3( Fw, Dw + Fw/2, 0); % kapitola 5.7.2
        an = max3( Fs, Ds + Fs/2, 0); % je tohle hybridni diferencovani
        as = max3(-Fn, Dn - Fn/2, 0); % chtel jsem to obecneji ale asi to nejde tak lehce
        ap = ae + aw + an + as;
        
        an = 0;
        as = 0;
        aw = 0;
        
        equation = assign(index, ap, an, as, ae, aw, nx, ny);
        rhs = bounds.w;
    end
end

if i == ny % vychodni kraj
    if bounds.e_is_d % jestli je dirichlet na vychode
        equation(index) = 1;
        rhs = bounds.e;
    else % jestli je na vychode neumann
        ae = max3(-Fe, De - Fe/2, 0); % podle knizky strana 124
        aw = max3( Fw, Dw + Fw/2, 0); % kapitola 5.7.2
        an = max3( Fs, Ds + Fs/2, 0); % je tohle hybridni diferencovani
        as = max3(-Fn, Dn - Fn/2, 0); % chtel jsem to obecneji ale asi to nejde tak lehce
        ap = ae + aw + an + as;
        
        an = 0;
        as = 0;
        ae = 0;
        
        equation = assign(index, ap, an, as, ae, aw, nx, ny);
        rhs = bounds.e;
    end
end

if j == 1 % jizni kraj
    if bounds.s_is_d % jestli je dirichlet na jihu
        equation(index) = 1;
        rhs = bounds.s;
    else % jestli je na jihode neumann
        ae = max3(-Fe, De - Fe/2, 0); % podle knizky strana 124
        aw = max3( Fw, Dw + Fw/2, 0); % kapitola 5.7.2
        an = max3( Fs, Ds + Fs/2, 0); % je tohle hybridni diferencovani
        as = max3(-Fn, Dn - Fn/2, 0); % chtel jsem to obecneji ale asi to nejde tak lehce
        ap = ae + aw + an + as;
        
        ae = 0;
        as = 0;
        aw = 0;
        
        equation = assign(index, ap, an, as, ae, aw, nx, ny);
        rhs = bounds.s;
    end
end

if j == nx % zapadni kraj
    if bounds.n_is_d % jestli je dirichlet na severu
        equation(index) = 1;
        rhs = bounds.n;
    else % jestli je na severu neumann
        ae = max3(-Fe, De - Fe/2, 0); % podle knizky strana 124
        aw = max3( Fw, Dw + Fw/2, 0); % kapitola 5.7.2
        an = max3( Fs, Ds + Fs/2, 0); % je tohle hybridni diferencovani
        as = max3(-Fn, Dn - Fn/2, 0); % chtel jsem to obecneji ale asi to nejde tak lehce
        ap = ae + aw + an + as;
        
        an = 0;
        ae = 0;
        aw = 0;
        
        equation = assign(index, ap, an, as, ae, aw, nx, ny);
        rhs = bounds.n;
    end
end

if (i == 1 && j == 1 || i == 1 && j == nx || ...
        i == ny && j == 1 || i == ny && j == nx) %hnus
    equation(index) = 1; %rohy
    rhs = 0;
end


end
