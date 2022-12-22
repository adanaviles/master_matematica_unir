function I= trapecios(f,a,b,n)
% I=trapecios(f,a,b,n) obtiene la integral de f(x)
% con la fórmula de trapecios compuesta.
h =(b-a)/n; %defino el paso h a partir de los valores a, b y n
x = a:h:b; %defino los valores de esta variable
pesos = [1 2*ones(1,n -1) 1]; %pesos asociados a primera variable
%integral obtenida de plantear la funcion de los apuntes
I=h/2*sum(pesos.*f(x));
end