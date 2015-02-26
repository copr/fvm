function SU = calcPsourcesForU(SU, pstar, unx, uny, deltaX, deltaY)
for j=2:unx-1
    for i=2:uny-1
        SU(j,i) = SU(j,i) + (pstar(j, i) - pstar(j, i+1))*deltaY;%/(deltaX*deltaY);
    end
end
end