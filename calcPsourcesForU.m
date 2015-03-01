function SU = calcPsourcesForU(SU, pstar, unx, uny, deltaX, deltaY)
%napocitava zdroje vychazejici z rozdilu tlaku pro u-rovnice
for j=2:unx-1
    for i=2:uny-1
        SU(j,i) = SU(j,i) + (pstar(j, i) - pstar(j, i+1))*deltaY;
    end
end
end