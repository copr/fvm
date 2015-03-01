function [USpout, VSpout, USuout, VSuout] = calcSourceTerms(bounds, USp, VSp, USu, VSu, deltaX, deltaY, mu)
%spocita zdroje pro pripad ze jsou na krajich zadane zdi
USpout = zeros(size(USp));
VSpout = zeros(size(VSp));
USuout = zeros(size(USu));
VSuout = zeros(size(VSu));

types = bounds.types;

% 0 - zed, 1 - pohybujici se zed, 2 - inlet, 3 - outlet


if types.ntype == 0
    USpout(end-1, :) = -2*mu*deltaX/deltaY;
end
if types.stype == 0
    USpout(2, :) = -2*mu*deltaX/deltaY;
end


if types.wtype == 0
    VSpout(:, 2) = -2*mu*deltaY/deltaX;
end
if types.etype == 0
    VSpout(:, end-1) = -2*mu*deltaY/deltaX;
end

if types.ntype == 1
    USpout(end-1, :) =-2*mu*deltaX/deltaY;
    USuout(end-1, :) = 2*mu*bounds.movingWallSpeed*deltaX/deltaY;
end
if types.stype == 1
    USpout(2, :) =-2*mu*deltaX/deltaY;
    USuout(2, :) = 2*mu*bounds.movingWallSpeed*deltaX/deltaY;
end

if types.wtype == 1
    VSpout(:, 2) =-2*mu*deltaY/deltaX;
    VSuout(:, 2) = 2*mu*bounds.movingWallSpeed*deltaY/deltaX;
end
if types.etype == 1
    VSpout(:, end-1) =-2*mu*deltaY/deltaX;
    VSuout(:, end-1) = 2*mu*bounds.movingWallSpeed*deltaY/deltaX;
end

end

