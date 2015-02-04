function [a, b, Spom] = central_differencing(boundary_is_dirichlet, boundary_val, is_not_on_bound, D, F, Sp, Su, delta, koef)
Spom = Sp;
b = 0;
if is_not_on_bound % nad je jeste prvek
    a =  D - F/2;
else
    a = 0;
    if boundary_is_dirichlet
        b = boundary_val*koef*(2*D - F);
        Spom = Spom - koef*(2*D - F);
    else
        b = boundary_val*D*delta; % naka blbost
    end
end
