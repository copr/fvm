function [ u,v ] = checkOutlet( bounds, ustar, vstar )
% jen pro jeden outlet bacha
u = ustar;
v = vstar;
types = bounds.types;
Muin = 0;
Muout = 0;
Mvin = 0;
Mvout = 0;
if types.ntype == 2
    Muin = Muin + sum(ustar(end,:));
    Mvin = Mvin + sum(vstar(end,:));
end

if types.stype == 2
    Muin = Muin + sum(ustar(1,:));
    Mvin = Mvin + sum(vstar(1,:));
end

if types.wtype == 2
    Muin = Muin + sum(ustar(:, 1));
    Mvin = Mvin + sum(vstar(:, 1));
end

if types.etype == 2
    Muin = Muin + sum(ustar(:, end));
    Mvin = Mvin + sum(vstar(:, end));
end

if types.ntype == 3
    u(end, :) = ustar(end-1, :);
    v(end, :) = vstar(end-1, :);
    Muout = sum(u(end,:));
    Mvout = sum(v(end,:));
    if Muout ~= 0
        u(end, :) = u(end, :) * Muin/Muout;
    end
    if Mvout ~= 0
        v(end, :) = v(end, :) * Mvin/Mvout;
    end
end
if types.stype == 3
    u(1, :) = ustar(2, :);
    v(1, :) = vstar(2, :);
    Muout = sum(u(1,:));
    Mvout = sum(v(1,:));
    if Muout ~= 0
        u(1, :) = u(1, :) * Muin/Muout;
    end
    if Mvout ~= 0
        v(1, :) = v(1, :) * Mvin/Mvout;
    end
end

if types.wtype == 3
    u(:, 1) = ustar(:, 2);
    v(:, 1) = vstar(:, 2);
    Muout = sum(u(:,1));
    Mvout = sum(v(:,1));
    if Muout ~= 0
        u(:, 1) = u(:, 1) * Muin/Muout;
    end
    if Mvout ~= 0
        v(:, 1) = v(:, 1) * Mvin/Mvout;
    end
end
if types.etype == 3
    u(:, end) = ustar(:, end-1);
    v(:, end) = vstar(:, end-1);
    Muout = sum(u(:,end));
    Mvout = sum(v(:,end));
    if Muout ~= 0
        u(:, end) = u(:, end) * Muin/Muout;
    end
    if Mvout ~= 0
        v(:, end) = v(:, end) * Mvin/Mvout;
    end
end

end

