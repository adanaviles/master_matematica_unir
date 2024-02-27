% -- Examen
% -- Limpio variables
clear all
close all
% -- Establecemos los limites dados por las regiones
% Para x
a=0; b=3;
% Para y
c=0; d=4;

% Definimos los puntos x, y
x=linspace(a,b,200);
y=linspace(c,d,200);

% Definimos la funcion
f=@(x,y) (3-x).*y;
[X,Y] = meshgrid(x,y);
% Definimos x,y,z como puntos "random"
% Podemos ver que, tomando x=0, y=4, max(f(x,y))=12
% Y su valor minimo es 0
n=10000;
r=rand(n,3);
x=a+r(:,1)*(b-a);
y=c+r(:,2)*(d-c);
z=0+r(:,3)*(12-0);

% Iniciar el experimento de Monte Carlo
nc=0; 
n=10000; 

% Identificamos los puntos que cumplan el criterio y sumamos todos los
% sucesos, es decir, que la función este por debajo de la cota z

idx = z<=f(x,y)
nc=sum(idx);

% Definimos el hiperpoliedro R
R=(b-a)*(d-c)*(12-0);

% Ploteamos los resultados
mesh(X,Y,f(X,Y))

axis square
box on
hold on
% Satisfacen el criterio
plot3(x(idx,1), ...
    y(idx,1), ...
    z(idx,1), ...
    'ro', ...
    'MarkerSize', ...
    1) 
% No satisfacen el criterio
plot3(x(~idx,1), ...
    y(~idx,1), ...
    z(~idx,1), ...
    'go', ...
    'MarkerSize', ...
    1)

% Volumen estimado
vol_esti=R*nc/n;
