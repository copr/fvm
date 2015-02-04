function pstar = correctP(pcomma, pstar, alfa)
[nx, ny] = size(pstar);
pnx = nx - 2;
pny = ny - 2;
for j=1:pnx
    for i=1:pny
        obi = i+1;
        obj = j+1;
        pstar(obj,obi) = pstar(obj,obi) + alfa*pcomma(j,i);
    end
end
end