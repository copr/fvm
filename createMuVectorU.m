function [Mu, vectorU]= createMuVectorU(bounds, nx, ny)
n = nx*ny;
Mu = sparse(n,n);
vectorU = zeros(n,1);
for i=1:n
    if mod(i, nx) == 1
        Mu(i,i) =  1;
        vectorU(i) = bounds.s.uVal;
    end
    if i > n-nx
        Mu(i,i) = 1;
        vectorU(i) = bounds.e.uVal;
    end
    if i < nx
        Mu(i,i) = 1;
        vectorU(i) = bounds.w.uVal;
    end
    if mod(i, nx) == 0
        Mu(i,i) = 1;
        vectorU(i) = bounds.n.uVal;
    end
end
end