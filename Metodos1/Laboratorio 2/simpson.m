function I= simpson (f,a,b,n)
% I=simpson(f,a,b,n) obtiene la integral de f(x)
% con la fórmula de Simpson compuesta.
h =(b-a)/n; %defino el paso h a partir de los valores a, b y n
x = a:h:b; %defino los valores de esta variable
pesos = ones(1,n +1);%pesos asociados a primera variable
pesos(2:2: n) = 4; pesos(3:2:n -1) = 2;
%integral obtenida de plantear la funcion de los apuntes
I=h/3*sum(pesos.*f(x));
end