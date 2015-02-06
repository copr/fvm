function [ ae, aw, an, as, be, bw, bn, bs, Spom ] = hybrid(index, i,j,Fe,Fw,Fn,Fs,De,Dw ...
    ,Dn,Ds,Su,Spom,deltaX,deltaY,u,v, bounds, nx, ny, koef, vals)
%hybridni diferencovani
%predelat podle maxu
n = nx*ny;

if abs(Fn/Dn) < 2
    [an, bn, Spom] = central_differencing(bounds.n_is_d, vals(i+1,j), mod(index, nx) ~= 0, Dn, Fn, Spom, Su, deltaX, koef);
    [as, bs, Spom] = central_differencing(bounds.s_is_d, vals(i-1,j), mod(index, nx) ~= 1, Ds, -Fs, Spom, Su, deltaX, koef);
else
    [as, an, bs, bn, Spom] = upwind_differencing(bounds.s_is_d, vals(i-1,j), mod(index, nx) ~= 1, bounds.n_is_d, vals(i-1,j), mod(index, nx) ~= 0, ...
        Ds, Dn, Fs, Fn, Spom, Su, deltaX, v, koef);
end

if abs(Fe/De) < 2
    [ae, be, Spom] = central_differencing(bounds.e_is_d, vals(i,j+1), index <= n-nx, De, Fe, Spom, Su, deltaY, koef);
    [aw, bw, Spom] = central_differencing(bounds.w_is_d, vals(i,j-1), index > nx, Dw, -Fw, Spom, Su, deltaY, koef);
else
    [aw, ae, bw, be, Spom] = upwind_differencing(bounds.w_is_d, vals(i,j-1), index > nx, bounds.e_is_d, vals(i,j+1), index <= n - nx, ...
        Dw, De, Fw, Fe, Spom, Su, deltaY, u, koef);
end


end
