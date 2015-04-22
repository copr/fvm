function [Mg, Vg] = generateGlueEquations(Mnx, Mny, nx, ny, indexes, sizeM)
matriceSizeX = nx/Mnx + 1;
matriceSizeY = ny/Mny + 1;
[inx, iny] = size(indexes);
n = sizeM;
Mg = sparse(1,n);
Vg = zeros(1,1);
order= 1;
for i=1:iny
    for j=matriceSizeX:matriceSizeX:inx
        line = sparse(1, n);
        line(indexes(j,i)) = -1;
        line(indexes(j-1, i)) = 1;
        Mg(order, :) = line;
        Vg(order, 1) = 0;
        order = order+1;
    end
end
for j=1:inx
    if rem(j,matriceSizeX) ~= 0
        for i=matriceSizeY:matriceSizeY:iny
            line = sparse(1, n);
            line(indexes(j,i)) = -1;
            line(indexes(j, i-1)) = 1;
            Mg(order, :) = line;
            Vg(order, 1) = 0;
            order = order+1;
        end
    end
end
end
