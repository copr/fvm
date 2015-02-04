function [ u,v ] = checkOutlet( bounds, ustar, vstar )
% jen pro jeden outlet bacha
u = ustar;
v = vstar;
types = bounds.types;
Muin = 0;
Muout = 0;
Mvin = 0;
Mvout = 0;
if types.ntype == 1
    Muin = Muin + sum(ustar(1,:));
    Mvin = Mvin + sum(vstar(1,:));
end

if types.stype == 1
    Muin = Muin + sum(ustar(end,:));
    Mvin = Mvin + sum(vstar(end,:));
end

if types.wtype == 1
    Muin = Muin + sum(ustar(:, 1));
    Mvin = Mvin + sum(vstar(:, 1));
end

if types.etype == 1
    Muin = Muin + sum(ustar(:, end));
    Mvin = Mvin + sum(vstar(:, end));
end

if types.ntype == 2
    u(1, :) = ustar(2, :);
    v(1, :) = vstar(2, :);
    u(1, :) = u(1, :) * Muin/sum(u(1,:));
    v(1, :) = v(1, :) * Mvin/sum(v(1,:));
end
if types.stype == 2
    u(end, :) = ustar(end-1, :);
    v(end, :) = vstar(end-1, :);
    u(end, :) = u(end, :) * Muin/sum(u(end, :));
    v(end, :) = v(end, :) * Mvin/sum(v(end, :));
end
if types.wtype == 2
    u(:, 1) = ustar(:, 2);
    v(:, 1) = vstar(:, 2);
    u(:, 1) = u(:, 1) * Muin/sum(u(:, 1));
    v(:, 1) = v(:, 1) * Mvin/sum(v(:, 1));
end
if types.etype == 2
    u(:, end) = ustar(:, end-1);
    v(:, end) = vstar(:, end-1);
    u(:, end) = u(:, end) * Muin/sum(u(:, end));
    v(:, end) = v(:, end) * Mvin/sum(v(:, end));
end

end

