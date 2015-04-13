function [u,v] = getCenters(ustar, vstar)
%z hodnot ktere vyhodi simple spocita hodnoty ve stredech
[unx, uny] = size(ustar);
u = zeros(unx-2, uny-1);
[vnx, vny] = size(vstar);
v = zeros(vnx-1, vny-2);
for i=1:vnx-1
    v(i,:) = (vstar(i,2:end-1) + vstar(i+1,2:end-1))./2;
end

for j=1:uny-1
    u(:,j) = (ustar(2:end-1,j) + ustar(2:end-1,j+1))./2;
end