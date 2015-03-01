function [equation, rhs] = generateNonBoundaryEquation(i,j ,Su, Sp, allF, allD, nx, ny)
% Vygeneruje jednu rovnici
% , ktera NEni na okrajich

equation = zeros(1, nx*ny);
rhs = 0;

index = (i-1)*nx + j;

Fe = allF(index, 1); Fw = allF(index, 2);
Fn = allF(index, 3); Fs = allF(index, 4);

De = allD(index, 1); Dw = allD(index, 2);
Dn = allD(index, 3); Ds = allD(index, 4);

ae = max3(-Fe, De - Fe/2, 0); % podle knizky strana 124
aw = max3( Fw, Dw + Fw/2, 0); % kapitola 5.7.2
an = max3( Fs, Ds + Fs/2, 0); % je tohle hybridni diferencovani
as = max3(-Fn, Dn - Fn/2, 0); % chtel jsem to obecneji ale asi to nejde tak lehce
ap = ae + aw + an + as + Sp(j,i);

equation = assign(index, ap, an, as, ae, aw, nx, ny);
rhs = Su(j,i);


end