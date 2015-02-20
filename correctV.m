function vstar = correctV(pcomma, vstar, deltaX, Mv)
%oprava vcek
[nx,ny] = size(vstar);
vnx = nx - 2;
vny = ny - 2;
for i=1:vny
    for j=1:vnx
        obi = i + 1;
        obj = j + 1;
        index = (i-1)*vnx + j;
        vstar(obj,obi) = vstar(obj,obi) + (pcomma(j, i) - pcomma(j+1, i)) * (deltaX/Mv(index, index));
    end
end
end