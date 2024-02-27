function [x1, t, I] = budi(f,a,b,tol, maxiter)
%Metodo de la busqueda dicotomica
tic
epsilon = 1e-5;
I=0;
while abs(b-a)>tol && I < maxiter
    x1=(a+b)/2;
    xa=x1-epsilon;
    xb=x1+epsilon;
    fa=feval(f,a);
    fb=feval(f,b);
    if fa<fb
        b=xb;
    elseif fa>fb
        a=xa;
    else
        a=xa;
        b=xb;
    end
    I=I+1;
end
t=toc;
end