function [USpout, VSpout, USuout, VSuout] = calcSourceTerms(bounds, USp, VSp, USu, VSu, deltaX, deltaY, mu)
%spocita zdroje pro pripad ze jsou na krajich zadane zdi
USpout = zeros(size(USp));
VSpout = zeros(size(VSp));
USuout = zeros(size(USu));
VSuout = zeros(size(VSu));

types = bounds.types;

% 0 - zed, 1 - pohybujici se zed, 2 - inlet, 3 - outlet


if types.ntype == 0
    USpout(end, :) = -2*mu*deltaX/deltaY;
end
if types.stype == 0
    USpout(1, :) = -2*mu*deltaX/deltaY;
end


if types.wtype == 0
    VSpout(:, 1) = -2*mu*deltaY/deltaX;
end
if types.etype == 0
    VSpout(:, end) = -2*mu*deltaY/deltaX;
end

if types.ntype == 1
    USpout(end, :) =-2*mu*deltaX/deltaY;
    USuout(end, :) = 2*mu*bounds.u.n*deltaX/deltaY;
end
if types.stype == 1
    USpout(1, :) =-2*mu*deltaY/deltaY;
    USuout(1, :) = 2*mu*bounds.u.s*deltaY/deltaY;
end


if types.wtype == 1
    VSpout(:, 1) =-2*mu*deltaX/deltaX;
    VSuout(:, 1) = 2*mu*bounds.v.w*deltaX/deltaX;
end
if types.etype == 1
    VSpout(:, end) =-2*mu*deltaY/deltaX;
    VSuout(:, end) = 2*mu*bounds.v.e*deltaY/deltaX;
end

end

