function [ Ms, Vs, Fs, Ds, Sus, Sps ] = giveMeAll( Su, Sp, allF, allD, Mnx, Mny, nx, ny)
%vytvori rozdelene matice a vektory, pro kazdou matici vrati Fka Dcka a
%zdroje ktere budou potreba pro vytvoreni rovnic
%prejmenovat
% numberOfMatrices = Mnx*Mny;
matriceSizeX = nx/Mnx;
matriceSizeY = ny/Mny;
for i=1:Mnx
    for j=1:Mny
        index = (j-1)*Mnx + i;
        if i == 1
            My = matriceSizeX;
            ki = 0;
        else
            My = matriceSizeX+1;
            ki = 1;
        end
        if j == 1
            Mx = matriceSizeY;
            kj = 0;
        else
            Mx = matriceSizeY+1;
            kj = 1;
        end
        Ms(index).indexes = sparse(Mx*My, Mx*My);
        Vs(index).indexes = zeros(Mx*My, 1);
        Fs(index).indexes = allF((j-1)*matriceSizeX+1-kj:j*matriceSizeX, (i-1)*matriceSizeY+1-ki:i*matriceSizeY); 
        Ds(index).indexes = allD((j-1)*matriceSizeX+1-kj:j*matriceSizeX, (i-1)*matriceSizeY+1-ki:i*matriceSizeY);
       
        Sus(index).indexes = [zeros(Mx-1, Mx-matriceSizeX) ,Su((j-1)*matriceSizeX+1:j*matriceSizeX, (i-1)*matriceSizeY+1:i*matriceSizeY); zeros(kj, ki), zeros(My-matriceSizeY, My-1)];
        Sps(index).indexes = [zeros(Mx-1, Mx-matriceSizeX) ,Sp((j-1)*matriceSizeX+1:j*matriceSizeX, (i-1)*matriceSizeY+1:i*matriceSizeY); zeros(kj, ki), zeros(My-matriceSizeY, My-1)];
    end
end
end

