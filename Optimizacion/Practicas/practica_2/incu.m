function [x_gorro, t, I] = incu(f,a,b,tol, maxiter)
tic;
x1 = a;
x3 = b;
x2 = (x1+x3)/2;
x0 = 1e10;
f1=feval(f,x1);
f2=feval(f,x2);
f3=feval(f,x3);
numerador = (x2^2-x3^2)*f1+(x3^2-x1^2)*f2+(x1^2-x2^2)*f3;
denominador = 2*((x2-x3)*f1+(x3-x1)*f2+(x1-x2)*f3);
x_gorro = numerador/denominador;
f_gorro = feval(f,x_gorro);
I=1; %Aqui ya tendria una iteracion para el minimo
while abs(x_gorro-x0)>tol && I<maxiter
    if (x1<x_gorro) && (x_gorro<x2) % x1<x_gorro<x2
        if f_gorro<=f2
            x3=x2;
            f3=f2;
            x2=x_gorro;
            f2=f_gorro;
        else
            x1=x_gorro;
            f1=f_gorro;
        end
    elseif  (x2<x_gorro) && (x_gorro<x3) % x2<x_gorro<x3
        if f_gorro<=f2
           x1=x2;
           f1=f2;
           x2=x_gorro;
           f2=f_gorro;
        else
            x3=x_gorro;
            f3=f_gorro;
        end
    end
    I=I+1;
    x0=x_gorro;
    numerador = (x2^2-x3^2)*f1+(x3^2-x1^2)*f2+(x1^2-x2^2)*f3;
    denominador = 2*((x2-x3)*f1+(x3-x1)*f2+(x1-x2)*f3);
    x_gorro = numerador/denominador;
    f_gorro = feval(f,x_gorro);
end
t=toc;
end