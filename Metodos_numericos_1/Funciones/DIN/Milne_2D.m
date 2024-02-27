function I= Milne_2D (f,a,b,n,c,d,m)
% I=Milne_2D(f,a,b,n,c,d,m) obtiene la integral de f(x,y)
% con la fórmula de Simpson compuesta.
h=(b-a)/n; %defino el paso h a partir de los valores a, b y n
k=(d-c)/m; %defino el paso k a partir de los valores c, d y m
x=a:h:b; %defino los valores de la primera variable
y=c:k:d; %defino los valores de la segunda variable
pesos_n = ones(1,n +1)*7 ; %pesos asociados a la primera variable
pesos_n (2:2: n)=32 ; pesos_n (3:4: n)=12 ; pesos_n (5:4:n -1) = 14;
pesos_m = ones(1,m +1)*7 ; %pesos asociados a la segunda variable
pesos_m(2:2: m) = 32; pesos_m(3:4:m) = 12; pesos_m(5:4:n-1)=14;
%matriz de pesos correspondiente al producto de los otros dos:
Pesos=pesos_n.*pesos_m';
%integral obtenida generalizar la ecuación de 1 a 2 variables con las
%correspondientes matrices
I=h*k*4/45/45*sum(sum(Pesos.*f(x,y)));
end