function bool = convergence(sources, myep)
%testuje konvergenci reseni, sources jsou napocitane zdroje v kazdem
%kontrolnim objemu
logic = sources > myep;
if sum(logic) == 0
    bool = true;
else
    bool = false;
end
end