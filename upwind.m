function [ ae, aw, an, as, be, bw, bn, bs, Spom ] = upwind(i,Fe,Fw,Fn,Fs,De,Dw ...
    ,Dn,Ds,Su,Spom,deltaX,deltaY,u,v, bounds, nx, ny )
n = nx*ny;

[as, an, bs, bn, Spom] = upwind_differencing(bounds.s_is_d, bounds.s, i > ny, bounds.n_is_d, bounds.n, i <= n - ny, ...
    Ds, Dn, Fs, Fn, Spom, Su, deltaY, v);

[aw, ae, bw, be, Spom] = upwind_differencing(bounds.w_is_d, bounds.w, mod(i, ny) ~= 1, bounds.e_is_d, bounds.e, mod(i, ny) ~= 0, ...
    Dw, De, Fw, Fe, Spom, Su, deltaX, u);

end

