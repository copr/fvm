function [ u,v ] = checkOutlet( bounds, ustar, vstar )
% kontorluje jestli je zadana outlet boundary podminka a pouziva ji
u = ustar;
v = vstar;
types = bounds.types;
Muin = 0;
Muout = 0;
Mvin = 0;
Mvout = 0;
if types.ntype == 2
    Muin = Muin + sum(ustar(end,2:end-1));
    Mvin = Mvin + sum(vstar(end,2:end-1));
end

if types.stype == 2
    Muin = Muin + sum(ustar(1,2:end-1));
    Mvin = Mvin + sum(vstar(1,2:end-1));
end

if types.wtype == 2
    Muin = Muin + sum(ustar(2:end-1, 1));
    Mvin = Mvin + sum(vstar(2:end-1, 1));
end

if types.etype == 2
    Muin = Muin + sum(ustar(2:end-1, end));
    Mvin = Mvin + sum(vstar(2:end-1, end));
end

if types.ntype == 3
% 
    u(end, 15:end-1) = ustar(end-1, 15:end-1);
    v(end, 15:end-1) = vstar(end-1, 15:end-1);
%    Muout = sum(u(end,2:end-1));
    Mvout = sum(v(end,15:end-1));
    if Mvout ~= 0
        v(end, 15:end-1) = v(end, 15:end-1) .* Mvin/Mvout;
    end
end
if types.stype == 3
%     u(1, 2:end-1) = ustar(2, 2:end-1);
    v(1, 2:end-1) = vstar(2, 2:end-1);
    Mvin = sum(v(end, 2:end-1));
    Mvout = sum(v(1,2:end-1));
%     if Muout ~= 0
%         u(1, :) = u(1, :) * Muin/Muout;
%     end
   if Mvout ~= 0
        v(1, 2:end-1) = v(1, 2:end-1) .* Mvout/Mvin;
   end
end

if types.wtype == 3
    u(:, 1) = ustar(:, 2);
    v(:, 1) = vstar(:, 2);
    Muout = sum(u(2:end-1,1));
    Mvout = sum(v(2:end-1,1));
    if Muout ~= 0
        u(:, 1) = u(:, 1) .* Muin/Muout;
    end
    if Mvout ~= 0
        v(:, 1) = v(:, 1) .* Mvin/Mvout;
    end
end
if types.etype == 3
    
    Muin = sum(ustar(2:end-1, 1));
    Muout = sum(ustar(2:end-1,end-1));
    v(2:end-1, end) = vstar(2:end-1, end-1);
    u(2:end-1, end) = ustar(2:end-1, end-1);
    if Muout ~= 0
        u(2:end-1, end) = u(2:end-1, end) .* Muin/Muout;
    end

%         v(:, end) = v(:, end) .* Mvin/Mvout;
end

end

