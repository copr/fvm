function [ M, vector ] = relax( Min, vectorIn, alfa, nx, ny, old)
%relaxace 
M = Min;
vector = vectorIn;
uolds = reshape(old, nx*ny, 1);
for index=1:nx*ny
    j = rem(index-1, nx) + 1;
    i =	floor(index/nx) + 1;
    if i > 1 && i < ny && j > 1 && j < nx
%         'dostali se sem'
%         i
%         j
%         index
%         waitforbuttonpress
        M(index, index) = M(index, index) / alfa;
        vector(index) = vector(index) + (1-alfa)*M(index, index)*uolds(index);
    end
end
end

% D = diag(diag(Min));
% M = (Min - D) + D./alfa;
% uolds = reshape(old, nx*ny, 1);
% vector = vectorIn + (1-alfa)*(diag(M)).*uolds;
% end