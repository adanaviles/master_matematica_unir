syms x;
f=sin(x)+x^2;

[x_rein,I, cambios_alfa] = rein(f,2,1e-5)

function [xk,I, cambios_alfa] = rein(f,x1,tol)
%Metodo de las rectas inexactas
c1=0.1;
c2=0.9;
xk=x1;
I=0;
cambios_alfa=0;
% Definimos los ai
al = 0; % a_l
ar = 1000;
ak = al+2;
f_prima = eval(subs(diff(f),xk));
while abs(f_prima)>tol && I<100
    % Defino todos los valores necesarios
    fxk = eval(subs(f,xk));
    f_prima_xk = eval(subs(diff(f),xk));
    dk = -sign(f_prima_xk);
    fxk_ak = eval(subs(f,xk+ak*dk));
    f_prima_xk_ak = eval(subs(diff(f),xk+ak*dk));
    % Primera condicion de wolfe, mientras no se cumpla sigo
    while fxk_ak > (fxk+c1*ak*dk*f_prima_xk)
        disp('wolfe1')
       % si no se cumple la condicion de wolfe
        ar=ak;
        ak = (al+ar)/2;
        fxk = eval(subs(f,xk));
        f_prima_xk = eval(subs(diff(f),xk));
        dk = -sign(f_prima_xk);
        fxk_ak = eval(subs(f,xk+ak*dk));
        f_prima_xk_ak = eval(subs(diff(f),xk+ak*dk));
        cambios_alfa=cambios_alfa+1;
    end
     % Segunda condicion de wolfe, mientras no se cumpla sigo
    while abs(dk*f_prima_xk_ak)/abs(dk*f_prima_xk) > c2
       % si no se cumple la condicion de wolfe
        disp('wolfe2')
        al=ak
        ak = (al+ar)/2
        if ar==10000
            ak = 2*ak;
        end
        f_prima_xk_ak = eval(subs(diff(f),xk+ak*dk))
        cambios_alfa=cambios_alfa+1;
    end
    % Llegados a este punto se cumplen todas las condiciones
    I=I+1
    xk=xk+ak*dk;
    f_prima = eval(subs(diff(f),xk));
end
end