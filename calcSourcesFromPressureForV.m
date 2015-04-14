function SV = calcSourcesFromPressureForV(SV, pstar, vnx, vny, deltaX, deltaY)
%napocitava zdroje vychazejici z rozdilu tlaku pro v-rovnice
for j=2:vnx-1
    for i=2:vny-1
        SV(j,i) = SV(j,i) + (pstar(j, i) - pstar(j+1, i))*deltaX;
    end
end
end 