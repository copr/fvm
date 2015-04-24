function [Mout, vectorOut] = generateBoundaryEquations(vals, indexes)
%vygeneruje rovnice ktere upevnuji hodnoty na krajich
order = 1;
[nx, ny] = size(indexes);
n = nx*ny;
Mout = sparse(1,n);
vectorOut = zeros(1,1);
[inx, iny] = size(indexes);
for j=1:inx
    for i=1:iny
        if(i == 1 ||  i == ny || j == 1 || j == nx)
            line = assign(indexes(j, i), 1, 0, 0, 0, 0, nx, ny);
            Mout(order, :) = line;
            vectorOut(order, 1) = 0;
            order = order + 1;
        end
%         if ( j == nx && (i ~= 1 && i ~= ny))
%             vectorOut(order-1, 1) = 1;
%         end
    end
end
end

