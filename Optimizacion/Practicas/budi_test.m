f=@(x) sin(x)+x^2;
a=-1;
b=1;

[xoptimo,I] = budi(f,a,b,1e-2);

function [x1,I] = budi(f,a,b,tol)
%Metodo de la busqueda dicotomica
epsilon = 1e-5;
I=0;
while abs(b-a)>tol
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
end
