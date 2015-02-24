v.e = 0;
v.n = 0;
v.s = 0;
v.w = -1;
v.e_is_d = true;
v.n_is_d = true;
v.s_is_d = true;
v.w_is_d = false;


n = 20;

Su = zeros(n, n);
Sp = zeros(n, n);

fvm(1,0,1,1,1,1,n,n,v,Su,Sp);