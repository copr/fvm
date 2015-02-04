function [Mv, vectorV]= createMvVectorV(bounds, nx, ny)
n = nx*ny;
Mv = sparse(n,n);
vectorV = zeros(n,1);
for i=1:n
    if mod(i, nx) == 1
        Mv(i,i) =  1;
        vectorV(i) = bounds.s.vVal;
    end
    if i > n-nx
        Mv(i,i) = 1;
        vectorV(i) = bounds.e.vVal;
    end
    if i < nx
        Mv(i,i) = 1;
        vectorV(i) = bounds.w.vVal;
    end
    if mod(i, nx) == 0
        Mv(i,i) = 1;
        vectorV(i) = bounds.n.vVal;
    end
end
end