function [bigMatrix, bigVector] = generateSeperateMatrices(Su, Sp, allF, allD, nx, ny, Mnx, Mny, vals)
%vytvori velkou matici z Mnx*Mny malych matic
[Ms, Vs, Fs, Ds, Sus, Sps, indexes] = giveMeAll(Su, Sp, allF, allD, Mnx, Mny, nx, ny);

bigMatrix = sparse(0,0);
bigVector = [];
for i=1:Mnx*Mny
    [x, y, ~] = size(Fs(i).indexes);
    [matrice, vector] = generateNonBoundaryEquations(Sus(i).indexes, Sps(i).indexes, Fs(i).indexes, Ds(i).indexes, Ms(i).indexes, Vs(i).indexes, x, y);
    bigMatrix = mergeMatrices(bigMatrix, matrice);
    bigVector = [bigVector; vector];
end
[Mb, vectorB] = generateBoundaryEquations(vals, indexes);
bigMatrix = mergeMatrixAndBounds(bigMatrix, Mb);
bigVector = [bigVector; vectorB];

[sizeM, ~] = size(bigMatrix);

[Mg, vectorG] = generateGlueEquations(Mnx, Mny, nx, ny, indexes, sizeM);

bigMatrix = mergeMatrixAndBounds(bigMatrix, Mg);
bigVector = [bigVector; vectorG];

[sizeG, ~] = size(Mg);
[sizeB, ~] = size(Mb);

res = bigMatrix\bigVector;
% res = pcg_chol(bigMatrix, bigVector, 0.000000000001);

%full(bigMatrix)
%full(bigVector)
res = res(1:end-sizeG-sizeB);
res = getFromRes(res, indexes);
result = getResult(res, nx, ny, Mnx, Mny);
figure(1)
mesh(res)
figure(2)
mesh(result);
end