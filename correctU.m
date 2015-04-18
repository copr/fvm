function ustar = correctU(pcomma, ustar, deltaY, Mu)
%oprava Ucek
[unx, uny] = size(ustar);
for i=2:uny-1
    for j=2:unx-1
        index = (i-1)*unx + j;
        ustar(j,i) = ustar(j,i) + (pcomma(j-1, i-1) - pcomma(j-1, i)) * (deltaY/Mu(index, index));
    end
end
end