function [ AB] = mergeMatrices(A, B)
%spoji dve matice do jedne
[Ax, Ay] = size(A);
[Bx, By] = size(B);
AB = [A, sparse(Ax, By); B, sparse(Bx, Ay)];
end

