function vstar = correctV(pcomma, vstar, deltaX, Mv)
%oprava vcek
[vnx, vny] = size(vstar);
for i=2:vny-1
    for j=2:vnx-1
        index = (i-1)*vnx + j;
        vstar(j,i) = vstar(j,i) + (pcomma(j, i) - pcomma(j+1, i)) * (deltaX/Mv(index, index));
    end
end
end