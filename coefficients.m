function [ap,an,as,ae,aw,Su] = coefficients(index, gama, deltaX, deltaY,Su, Sp, nx, ny, bounds, ro, u, v)
%napocitava koeficienty a zdrojove prvky
j = mod(index - 1, ny) + 1;
i = floor((index-1)/nx) + 1;
Spom = Sp;
Fw = ro(i,j)*u(i,j)*deltaY;
Fn = ro(i,j)*v(i,j)*deltaX;
Fe = ro(i,j)*u(i,j)*deltaY;
Fs = ro(i,j)*v(i,j)*deltaX;
Dw = (gama(i,j)*deltaY)/deltaX;
Dn = (gama(i,j)*deltaX)/deltaY;
Ds = (gama(i,j)*deltaX)/deltaY;
De = (gama(i,j)*deltaY)/deltaX;

[ae, aw, an, as, be, bw, bn, bs, Spom] = hybrid(index, i, j, Fe, Fw, Fn, Fs, ...
    De, Dw, Dn, Ds, Su, Spom, deltaX, deltaY, u(i,j), v(i,j), bounds, nx, ny, 1);


Su = Su(i, j) + bn + bs + bw + be;
ap = as + an + ae + aw - Spom;
end