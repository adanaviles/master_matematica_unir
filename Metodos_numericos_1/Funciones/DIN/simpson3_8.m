function I= simpson3_8 (f,a,b,n)
% I=simpson(f,a,b,n) obtiene la integral de f(x)
% con la fórmula de Simpson compuesta.
h = (b-a)/n;
x = a:h:b;
pesos = ones (1,n +1) ;
pesos (2:3: n) = 3; pesos (3:3: n) = 3; pesos (4:3:n -1) = 2;
I=3*h /8* sum ( pesos.*f(x));
end