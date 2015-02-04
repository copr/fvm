function [ A ] = putInside( B, C )
A = B;
A(2:end-1, 2:end-1) = C;
end

