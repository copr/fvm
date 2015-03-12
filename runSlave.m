v.e = 0;
v.n = 0;
v.s = 0;
v.w = 0;
v.e_is_d = true;
v.n_is_d = true;
v.s_is_d = true;
v.w_is_d = true;


n = 50;

Su = ones(n, n);
Sp = zeros(n, n);

gama = 1;
ro = 1;

fvm(0,0,1,1,gama, ro,n,n,v,Su,Sp);



