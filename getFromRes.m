function [ result ] = getFromRes( res, indexes)
[n, ~] = size(res);
result = zeros(size(indexes));
for i=1:n
    [r,c] = find(indexes == i);
    result(r,c) = res(i);
end
end

