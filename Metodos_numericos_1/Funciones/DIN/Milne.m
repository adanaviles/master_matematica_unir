function I= Milne (f,a,b,n)
% I=simpson(f,a,b,n) obtiene la integral de f(x)
% con la fórmula de Simpson compuesta.
h = (b-a)/n;
x = a:h:b;
pesos = ones (1,n +1)*7 ;
pesos (2:2: n)=32 ; pesos (3:4: n)=12 ; pesos (5:4:n -1) = 14;
I=2*h /45* sum ( pesos.*f(x));
end