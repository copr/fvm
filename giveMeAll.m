function [ Ms, Vs, Fs, Ds, Sus, Sps, indexes, oldValues] = giveMeAll( Su, Sp, allF, allD, Mnx, Mny, nx, ny, olds)
%vytvori rozdelene matice a vektory, pro kazdou matici vrati Fka Dcka a
%zdroje ktere budou potreba pro vytvoreni rovnic
%prejmenovat
% numberOfMatrices = Mnx*Mny;
% deltaX = 0.167;
% deltaY = 0.167;
% V = deltaX*deltaY
matriceSizeX = nx/Mnx;
matriceSizeY = ny/Mny;
indexes = zeros(matriceSizeX + (Mnx-1)*(matriceSizeX+1), matriceSizeY + (Mny-1)*(matriceSizeY+1));
for i=1:Mny
    for j=1:Mnx
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
        
        %zdroje pro znasobene uzly jsou nula, tady ty nuly pridavam ke
        %zdrojum
        Sus(index).indexes = [zeros(kj, ki), zeros(kj, Sny); zeros(Snx, ki), Su((j-1)*matriceSizeX+1:j*matriceSizeX, (i-1)*matriceSizeY+1:i*matriceSizeY)];
        Sps(index).indexes = [zeros(kj, ki), zeros(kj, Sny); zeros(Snx, ki), Sp((j-1)*matriceSizeX+1:j*matriceSizeX, (i-1)*matriceSizeY+1:i*matriceSizeY)];
        oldValues(index).indexes = [zeros(kj, ki), zeros(kj, Sny); zeros(Snx, ki), olds((j-1)*matriceSizeX+1:j*matriceSizeX, (i-1)*matriceSizeY+1:i*matriceSizeY)];
        
        inds = reshape(1:Mx*My, Mx, My) + max(max(indexes));
        if i == 1 && j == 1
            indexes(1:Mx, 1:My) = inds;
        else
            indexes((j-1)*Mx+(j<2)*1:j*Mx-1*(j>1), (i-1)*My+(i<2)*1:i*My-1*(i>1)) = inds;
        end
    end
end
end

