function [ustar, vstar, pstar] = initUVPstar(nx, ny, bounds, ustar, vstar, pstar)
%inicializuje uvp pole
if nargin == 3
    ustar = zeros(nx + 2, ny + 1);
    vstar = zeros(nx + 1, ny + 2);
    pstar = zeros(nx + 2, ny + 2);
end

        ustar(:, 1) = bounds.u.w;
        vstar(:, 1) = bounds.v.w;
        pstar(:, 1) = 0;


        ustar(:, end) = bounds.u.e;
        vstar(:, end) = bounds.v.e;
        pstar(:, end) = 0;


        ustar(end, :) = bounds.u.n;
        vstar(end, :) = bounds.v.n;
        pstar(end, :) = 0;


        ustar(1, :) = bounds.u.w;
        vstar(1, :) = bounds.v.w;
        pstar(1, :) = 0;

end