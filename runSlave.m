clear;

v.e = 0;
v.n = 0;
v.s = 0;
v.w = 0;
v.e_is_d = true;
v.n_is_d = true;
v.s_is_d = true;
v.w_is_d = true;

n = 60;
Mnx = 2;
Mny = 2;

Su = zeros(n, n);
Su(2:end-1,2:end-1) = 1;
Sp = zeros(n, n);

gama = 1;
ro = 1;

u = 0;

[res1] = fvm(u,0,1,1,gama, ro,n,n,v,Su,Sp, Mnx, Mny);
[res2] = fvm2(u,0,1,1,gama, ro,n,n,v,Su,Sp);
figure('name', 'slozeny')
mesh(res1);
figure('name', 'neslozeny')
mesh(res2);
figure('name', 'chyba')
mesh(res1 - res2);


