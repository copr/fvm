function [bigMatrix, bigVector] = generateSeperateMatrices(Su, Sp, allF, allD, nx, ny, Mnx, Mny, vals)
%vytvori velkou matici z Mnx*Mny malych matic
[Ms, Vs, Fs, Ds, Sus, Sps, indexes] = giveMeAll(Su, Sp, allF, allD, Mnx, Mny, nx, ny);
Mb = sparse(2*(nx+ny)-2, nx*ny);
vectorB = zeros(2*(nx+ny)-2, 1);
bigMatrix = sparse(0,0);
bigVector = [];

for i=1:Mnx*Mny
    [x, y, ~] = size(Fs(i).indexes);
    [matrice, vector] = generateNonBoundaryEquations(Sus(i).indexes, Sps(i).indexes, Fs(i).indexes, Ds(i).indexes, Ms(i).indexes, Vs(i).indexes, x, y);
    bigMatrix = mergeMatrices(bigMatrix, matrice);
    bigVector = [bigVector; vector];
end

    
[Mb, vectorB] = generateBoundaryEquations(Mb, vectorB, nx, ny, vals, Mnx, Mny);
bigMatrix = mergeMatrixAndBounds(bigMatrix, Mb);
bigVector = [bigVector; vectorB];

[Mg, vectorG] = generateGlueEquations(Mg, vg);
bigMatrix = mergeMatrixAndBounds(bigMatrix, Mg);
bigVector = [bigVector; vectorG];
end