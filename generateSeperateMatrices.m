function [bigMatrix, bigVector] = generateSeperateMatrices(Su, Sp, allF, allD, nx, ny, Mnx, Mny)
%vytvori velkou matici z Mnx*Mny malych matic
[Ms, Vs, Fs, Ds, Sus, Sps] = giveMeAll(Su, Sp, allF, allD, Mnx, Mny, nx, ny);
bigMatrix = sparse(0,0);
bigVector = [];

for i=1:nx*ny
    [x, y] = size(Fs(i).indexes);
    [matrice, vector] = generateNonBoundaryEquations(Sus(i).indexes, Sps(i).indexes, Fs(i).indexes, Ds(i).indexes, Ms(i).indexes, Vs(i).indexes, x, y);
    bigMatrix = mergeMatrices(bigMatrix, matrice);
    bigVector = [bigVector; vector];
end
    
    
    
[matrice1, vector1] = generateNonBoundaryEquations(Su(1:matriceSizeX, 1:matriceSizeY), Sp(1:matriceSizeX, 1:matriceSizeY),...
    allF(1:matriceSizeX, 1:matriceSizeY), allD(1:matriceSizeX, 1:matriceSizeY), matrice1, vector1, matriceSizeX, matriceSizeY, nx+1);

[matrice2, vector2] = generateNonBoundaryEquations(Su(1:matriceSizeX, matriceSizeY:end), Sp(1:matriceSizeX, matriceSizeY:end),...
    allF(1:matriceSizeX, 1:matriceSizeY), allD(matriceSizeX:end, 1:matriceSizeY), matrice1, vector1, matriceSizeX+1, matriceSizeY, nx+1);

[matrice3, vector3] = generateNonBoundaryEquations(Su(matriceSizeX:end, 1:matriceSizeY), Sp(matriceSizeX:end, 1:matriceSizeY),...
    allF(matriceSizeX:end, 1:matriceSizeY), allD(1:matriceSizeX, 1:matriceSizeY), matrice1, vector1, matriceSizeX, matriceSizeY+1, nx+1);

[matrice4, vector4] = generateNonBoundaryEquations(Su(matriceSizeX:end, matriceSizeY:end), Sp(matriceSizeX:end, matriceSizeY:end),...
    allF(matriceSizeX:end, matriceSizeY:end), allD(matriceSizeX:end, matriceSizeY:end), matrice1, vector1, matriceSizeX+1, matriceSizeY+1, nx+1);

matrices = mergeMatrices(mergeMatrices(mergeMatrices(matrice1, matrice2), matrice3), matrice4);
vectors = [vector1; vector2; vector3; vector4];

