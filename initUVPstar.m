function [ustar, vstar, pstar] = initUVPstar(nx, ny, bounds, ustar, vstar, pstar)
%inicializuje uvp pole
if nargin == 3
    ustar = zeros(nx + 2, ny + 1);
    vstar = zeros(nx + 1, ny + 2);
    pstar = zeros(nx + 2, ny + 2);
end

if bounds.types.wtype == 2
    ustar(:, 1) = bounds.u.w;
    vstar(:, 1) = bounds.v.w;
    pstar(:, 1) = 0;
end
if bounds.types.etype == 2
    ustar(:, end) = bounds.u.e;
    vstar(:, end) = bounds.v.e;
    pstar(:, end) = 0;
end
if bounds.types.ntype == 2
    ustar(end, :) = bounds.u.n;
    vstar(end, :) = bounds.v.n;
    pstar(end, :) = 0;
end
if bounds.types.stype == 2
    ustar(1, :) = bounds.u.s;
    vstar(1, :) = bounds.v.s;
    pstar(1, :) = 0;
end

if bounds.types.wtype == 0
    ustar(:, 1) = 0;
    vstar(:, 1) = 0;
    pstar(:, 1) = 0;
end
if bounds.types.etype == 0
    ustar(:, end) = 0;
    vstar(:, end) = 0;
    pstar(:, end) = 0;
end
if bounds.types.ntype == 0
    ustar(end, :) = 0;
    vstar(end, :) = 0;
    pstar(end, :) = 0;
end
if bounds.types.stype == 0
    ustar(1, :) = 0;
    vstar(1, :) = 0;
    pstar(1, :) = 0;
end
end