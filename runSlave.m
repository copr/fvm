v.e = 10;
v.n = 0;
v.s = 0;
v.w = 0;
v.e_is_d = true;
v.n_is_d = false;
v.s_is_d = false;
v.w_is_d = true;


n = 40;

Su = ones(n, n+2);
Sp = zeros(n, n+2);

gama = 1;
ro = 1;

fvm(0,0,1,1,gama, ro,n,n,v,Su,Sp);



