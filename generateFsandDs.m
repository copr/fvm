function [allF, allD] = generateFsandDs(n, u, v, ro, gama, deltaX, deltaY)
allF = zeros(n, 4);
allD = zeros(n, 4);

for i=1:n
    Fw = u*ro*deltaY;
    Fe = Fw;
    Fs = v*ro*deltaX;
    Fn = Fs;
    Dw = deltaY*gama/deltaX;
    De = Dw;
    Ds = deltaX*gama/deltaY;
    Dn = Ds;
    
    allF(i, 1) = Fe; allF(i, 2) = Fw;
    allF(i, 3) = Fn; allF(i, 4) = Fs;
    
    allD(i, 1) = De; allD(i, 2) = Dw;
    allD(i, 3) = Dn; allD(i, 4) = Ds;
end

end