function [ result ] = getResult(res, nx, ny, Mnx, Mny)
result = zeros(nx, ny);
matriceSizeX = nx/Mnx+1;
matriceSizeY = ny/Mny+1;
[sizeX, sizeY] = size(res);
l = 1;

result = res;
for j=matriceSizeX:matriceSizeY-1:sizeX-(Mnx-1)
    result(j, :) = [];
end
for i=matriceSizeY:matriceSizeY-1:sizeY-(Mny-1)
    result(:, i) = [];
end

% for i=1:sizeY
%     
% end
end

