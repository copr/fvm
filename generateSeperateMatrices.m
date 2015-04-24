function [bigMatrix, bigVector, result] = generateSeperateMatrices(Su, Sp, allF, allD, nx, ny, Mnx, Mny, vals, alfa, olds)
%vytvori velkou matici z Mnx*Mny malych matic
[Ms, Vs, Fs, Ds, Sus, Sps, indexes, oldValues] = giveMeAll(Su, Sp, allF, allD, Mnx, Mny, nx, ny, olds);

bigMatrix = sparse(0,0);
bigVector = [];
vlajka1 = false;
vlajka2 = false;
for i=1:Mny
    for j=1:Mnx
        index = (i-1)*Mnx + j;
        [x, y, ~] = size(Fs(index).indexes);
        if i > 1
            vlajka1 = true;
        end
        if j > 1
            vlajka2 = true;
        end
        [matrice, vector] = generateNonBoundaryEquations(Sus(index).indexes, Sps(index).indexes, Fs(index).indexes, Ds(index).indexes, Ms(index).indexes, Vs(index).indexes, x, y, vlajka1, vlajka2);
        [mx, my] = size(oldValues(index).indexes);
        [x, y] = size(Sus(index).indexes);
        [matrice, vector] = relax(matrice, vector, alfa, mx, my, oldValues(index).indexes);
        bigMatrix = mergeMatrices(bigMatrix, matrice);
        bigVector = [bigVector; vector];
    end
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

res = res(1:end-sizeG-sizeB);
res = getFromRes(res, indexes);
result = getResult(res, nx, ny, Mnx, Mny);
end