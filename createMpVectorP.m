function [Mp, vectorP] = createMpVectorP(bounds, nx, ny)
n = nx*ny;
Mp = sparse(n,n);
vectorP = zeros(n,1);
for i=1:n
    if mod(i, nx) == 1
        Mp(i,i) =  1;
        vectorP(i) = bounds.s.pVal;
    end
    if i > n-nx
        Mp(i,i) = 1;
        vectorP(i) = bounds.e.pVal;
    end
    if i < nx
        Mp(i,i) = 1;
        vectorP(i) = bounds.w.pVal;
    end
    if mod(i, nx) == 0     
        Mp(i,i) = 1;
        vectorP(i) = bounds.n.pVal;
    end
end
end