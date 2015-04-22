function [allF, allD] = generateFsandDs(nx, ny, u, v, ro, gama, deltaX, deltaY)
allF = zeros(nx, ny);
allD = zeros(nx, ny);

for j=1:nx
    for i=1:ny
        Fw = u*ro*deltaY;
        Fe = Fw;
        Fs = v*ro*deltaX;
        Fn = Fs;
        Dw = deltaY*gama/deltaX;
        De = Dw;
        Ds = deltaX*gama/deltaY;
        Dn = Ds;
        
        allF(j, i, 1:4) = [Fe, Fw, Fn, Fs];
        allD(j, i, 1:4) = [De, Dw, Dn, Ds];
    end
end
end