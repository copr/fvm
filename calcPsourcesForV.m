function SV = calcPsourcesForV(SV, pstar, vnx, vny, deltaX, deltaY)
for j=2:vnx-1
    for i=2:vny-1
        SV(j,i) = (pstar(j, i) - pstar(j+1, i))*deltaX;%/(deltaX*deltaY);
    end
end
end