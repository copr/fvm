function [allF, allD] = generateFsandDs(nx, ny, u, v, ro, gama, deltaX, deltaY)
n = nx*ny;
allF = zeros(n, 4);
allD = zeros(n, 4);
index = 1;
for i=1:ny
    for j=1:nx
        if i == floor(ny/2)+1
            prevIndex = index-nx;
            allF(prevIndex, 1) = allF(prevIndex-1, 1); allF(prevIndex, 2) = allF(prevIndex-1, 2);
            allF(prevIndex, 3) = allF(prevIndex-1, 3); allF(prevIndex, 4) = allF(prevIndex-1, 4);
            
            allD(prevIndex, 1) = allD(prevIndex-1, 1); allD(prevIndex, 2) = allD(prevIndex-1, 2);
            allD(prevIndex, 3) = allD(prevIndex-1, 3); allD(prevIndex, 4) = allD(prevIndex-1, 4);
        else
            Fw = u*ro*deltaY;
            Fe = Fw;
            Fs = v*ro*deltaX;
            Fn = Fs;
            Dw = deltaY*gama/deltaX;
            De = Dw;
            Ds = deltaX*gama/deltaY;
            Dn = Ds;
            
            allF(index, 1) = Fe; allF(index, 2) = Fw;
            allF(index, 3) = Fn; allF(index, 4) = Fs;
            
            allD(index, 1) = De; allD(index, 2) = Dw;
            allD(index, 3) = Dn; allD(index, 4) = Ds;
        end
        index = index+1;
    end
end

end