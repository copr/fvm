function pstar = correctP(pcomma, pstar, alfa)
[nx, ny] = size(pstar);
pnx = nx;
pny = ny;
pstar = pstar + alfa.*pcomma;
% for j=2:pnx-1
%     for i=2:pny-1
%         pstar(j,i) = pstar(j,i) + alfa*pcomma(j-1,i-1);
%     end
% end
end