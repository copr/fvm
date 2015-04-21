function [ Ms, Vs, Fs, Ds, Sus, Sps, indexes ] = giveMeAll( Su, Sp, allF, allD, Mnx, Mny, nx, ny)
%vytvori rozdelene matice a vektory, pro kazdou matici vrati Fka Dcka a
%zdroje ktere budou potreba pro vytvoreni rovnic
%prejmenovat
% numberOfMatrices = Mnx*Mny;
indexes;
matriceSizeX = nx/Mnx;
matriceSizeY = ny/Mny;
for i=1:Mnx
    for j=1:Mny
        index = (i-1)*Mnx + j;
        if i == 1
            My = matriceSizeY;
            ki = 0;
        else
            My = matriceSizeY+1;
            ki = 1;
        end
        if j == 1
            Mx = matriceSizeX;
            kj = 0;
        else
            Mx = matriceSizeX+1;
            kj = 1;
        end
        Ms(index).indexes = sparse(Mx*My, Mx*My);
        Vs(index).indexes = zeros(Mx*My, 1);
        Fs(index).indexes = allF((j-1)*matriceSizeX+1-kj:j*matriceSizeX, (i-1)*matriceSizeY+1-ki:i*matriceSizeY, :); 
        Ds(index).indexes = allD((j-1)*matriceSizeX+1-kj:j*matriceSizeX, (i-1)*matriceSizeY+1-ki:i*matriceSizeY, :);
        %takovy trik abych si ted pomoh pozdeji to radsi predelat
        [~, Snx] = size((j-1)*matriceSizeX+1:j*matriceSizeX);
        [~, Sny] = size((i-1)*matriceSizeY+1:i*matriceSizeY);
        
        Sus(index).indexes = [zeros(Snx, ki) ,Su((j-1)*matriceSizeX+1:j*matriceSizeX, (i-1)*matriceSizeY+1:i*matriceSizeY); zeros(kj, ki), zeros(kj, Sny)];
        Sps(index).indexes = [zeros(Snx, ki) ,Sp((j-1)*matriceSizeX+1:j*matriceSizeX, (i-1)*matriceSizeY+1:i*matriceSizeY); zeros(kj, ki), zeros(kj, Sny)];
    end
end
end

