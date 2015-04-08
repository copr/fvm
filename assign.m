function line = assign(i, ap, an, as, ae, aw, nx, ny)
%priradi koeficienty do vektoru tak jak maji byt
line = sparse(1,nx*ny);

if an ~= 0 
    line(i + 1) = -an;
end
if as ~= 0
    line(i - 1) = -as;
end
if aw ~= 0
    line(i - nx) = -aw;
end
if ae ~= 0
    line(i + nx) = -ae;
end
line(i) = ap;
end