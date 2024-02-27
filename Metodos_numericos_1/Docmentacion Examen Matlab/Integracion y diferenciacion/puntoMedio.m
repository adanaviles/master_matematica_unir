f=@(x) sin (x).* exp (-x);
a =0;
b=pi /2;
n1 =4; 
n2 =8;
IPM1 = puntoMedio (f,a,b,n1)
IPM2 = puntoMedio (f,a,b,n2)

error = abs ([ IPM1 IPM2 ] -(1 - exp (-pi /2) ) /2)
function I= puntoMedio (f,a,b,n)
    % I=puntoMedio(f,a,b,n) obtiene la integral de f(x)
    % con la fórmula de punto medio compuesta.
    h = (b-a)/(n +2);
    x = a+h:h:b-h;
    I =2*h*sum(f(x(1:2:end)));
end