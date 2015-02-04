function [a1, a2, b1, b2, Spom] = upwind_differencing(a1_boundary_is_dirichlet, a1_boundary_val, a1_is_not_on_bound, ...
    a2_boundary_is_dirichlet, a2_boundary_val, a2_is_not_on_bound, D1, D2, F1, F2, Sp, Su, delta, u, koef)
% koef u simplu je to trochu jinak tak to tam nak potrebuju propasovat at
% to nemusim pro simple prepisovat
Spom = Sp;
b1 = 0;
b2 = 0;

if a1_is_not_on_bound
    a1 = D1 + max(F1, 0); %muze byt problem u nestrukturovanych gridu
else
    a1 = 0;
    if a1_boundary_is_dirichlet
        Spom = Spom - koef*(2*D1 + max(F1, 0));
        b1 = a1_boundary_val*koef*(2*D1 + max(F1, 0));
    else
        throw(MException('Not implemented', 'von neumann condition upwind'));
    end
end

if a2_is_not_on_bound
    a2 = D2 + max(0, -F2);
else % je na hranici
    a2 = 0;
    if a2_boundary_is_dirichlet
        Spom = Spom - koef*(2*D2 + max(0, -F2));
        b2 = a2_boundary_val*koef*(2*D2 + max(0, -F2));
    else
        throw(MException('Not implemented', 'von neumann condition upwind'));
        delta;
    end
end

end