function [USpout, VSpout, USuout, VSuout] = calcSourceTerms(bounds, USp, VSp, USu, VSu, deltaX, deltaY, mu)
USpout = zeros(size(USp));
VSpout = zeros(size(VSp));
USuout = zeros(size(USu));
VSuout = zeros(size(VSu));

types = bounds.types;

if types.ntype == 0
    USpout(end-1, :) = -mu*deltaX/deltaX;
end
if types.stype == 0
    USpout(2, :) = -mu*deltaX/deltaX;
end


if types.wtype == 0
    VSpout(:, 2) = -mu*deltaY/deltaY;
end
if types.etype == 0
    VSpout(:, end-1) = -mu*deltaY/deltaY;
end

if types.ntype == 1
    USpout(end-1, :) = -mu*deltaX/deltaX;
    USuout(end-1, :) = mu*bounds.u.n*deltaX/deltaX;
end
if types.stype == 1
    USpout(2, :) = -mu*deltaX/deltaX;
    USuout(2, :) = mu*bounds.u.s*deltaX/deltaX;
end


if types.wtype == 1
    VSpout(:, 2) = -mu*deltaY/deltaY;
    USuout(:, 2) = mu*bounds.v.w*deltaX/deltaX;
end
if types.etype == 1
    VSpout(:, end-1) = -mu*deltaY/deltaY;
    USuout(:, end-1) = mu*bounds.v.e*deltaX/deltaX;
end

end

