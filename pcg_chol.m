function [ x, it ] = pcg_chol( A,b, my_eps )
 it=0;
 L = ichol(A); % neuplny choleskeho rozklad A =~ LL^T
 x=zeros(size(b)); % pocatecni nasrel
 g_1=A*x-b;
 s_1=L\(L'\g_1);
 p_1=s_1;
 while norm(g_1)>= my_eps*(norm(b)) + my_eps && it < 1000
    Ap_1 = A*p_1;
    alpha = -dot(s_1,g_1)/dot(Ap_1,p_1);
    x = x + alpha * p_1;
    g_2 = g_1 + alpha*Ap_1;
    s_2 = L\(L'\g_2); % reseni dvou soustav s dolni troj. matici
    beta = dot(s_2,g_2)/dot(s_1,g_1);
    p_2 = s_2 + beta*p_1;  
    g_1=g_2;
    s_1=s_2;
    p_1=p_2;
    it = it + 1;
 end
end