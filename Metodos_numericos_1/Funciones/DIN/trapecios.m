function I= trapecios (f,a,b,n)
% I=trapecios(f,a,b,n) obtiene la integral de f(x)
% con la fórmula de trapecios compuesta.
h = (b-a)/n;
x = a:h:b;
pesos = [1 2* ones(1,n -1) 1];
I=h /2* sum ( pesos.*f(x));
end