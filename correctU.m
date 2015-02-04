function ustar = correctU(pcomma, ustar, deltaY, Mu)
%oprava Ucek
[nx,ny] = size(ustar);
unx = nx - 2;
uny = ny - 2;
for i=1:uny
    for j=1:unx
        obi = i + 1;
        obj = j + 1;
        index = (i-1)*unx + j;
        ustar(obj,obi) = ustar(obj,obi) + (pcomma(j, i) - pcomma(j , i+1))*deltaY/Mu(index,index);
    end
end
end