function [equation, rhs] = generateNonBoundaryEquation(i,j ,Su, Sp, allF, allD, nx, ny)
% Vygeneruje jednu rovnici
% , ktera NEni na okrajich

equation = zeros(1, nx*ny);
rhs = 0;

index = (i-1)*nx + j;

Fe = allF(j, i, 1); Fw = allF(j, i, 2);
Fn = allF(j, i, 3); Fs = allF(j, i, 4);

De = allD(j, i, 1); Dw = allD(j, i, 2);
Dn = allD(j, i, 3); Ds = allD(j, i, 4);


ae = max3(-Fe, De - Fe/2, 0); % podle knizky strana 124
aw = max3( Fw, Dw + Fw/2, 0); % kapitola 5.7.2
an = max3(-Fn, Dn - Fn/2, 0); % je tohle hybridni diferencovani
as = max3( Fs, Ds + Fs/2, 0); % chtel jsem to obecneji ale asi to nejde tak lehce
deltaF = Fe - Fw + Fn - Fs;
ap = ae + aw + an + as - Sp(j,i) + deltaF;

equation = assign(index, ap, an, as, ae, aw, nx, ny);
rhs = Su(j,i);


end