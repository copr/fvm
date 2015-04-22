function [M] = mergeMatrixAndBounds(Matrix, B)
[Bx, ~] = size(B);
M = [Matrix B'; B zeros(Bx, Bx)];
end