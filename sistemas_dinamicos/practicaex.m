clear all
close all
a=0; b=1; c=0; d=2.*pi;
x=linspace(a,b,200);
y=linspace(c,d,200);
% superficie
f=@(x,y) x.*exp(cos(y));
[X,Y] = meshgrid(x,y);
% Definir la cotas superior de f(x,y)
h=max(f(x,y));
% Definimos el hiperpoliedro R
R=(b-a)*(d-c)*h;
% Iniciar el experimento de Monte Carlo
nc=0; % aciertos
n=1000; %numero de intentos
%--------------
mesh(X,Y,f(X,Y))
axis square
box on
hold on
%--------------.
r=rand(n,3);
%--------------Definimos el hiperpoliedro R [a,b]x[c,d]xh
x=a+r(:,1)*(b-a);
y=c+r(:,2)*(d-c);
z=r(:,3)*h;
%--------------Identify the random points that satisfy the criterion
idx=z<=f(x,y);
%--------------Count the number of success
nc=sum(idx);
%--------------Plot the results
plot3(x(idx,1), ...
    y(idx,1), ...
    z(idx,1), ...
    'ro', ...
    'MarkerSize', ...
    1) % The points satisfying the criterion
plot3(x(~idx,1), ...
    y(~idx,1), ...
    z(~idx,1), ...
    'go', ...
    'MarkerSize', ...
    1) % The points that not satify the criterion

vol_esti=R*nc/n;
% Calcular el valor exacto de la integral
vol_real=integral2(f,a,b,c,d);
fprintf('La probabilidad de éxito es:%d\n',nc/n)
fprintf('El volumen aproximado es:%d\n',vol_esti)
fprintf('El volumen real es:%d\n',vol_real)
fprintf('El error estimado entre método monte Carlo y integral2 es: %d\n',abs(vol_esti-vol_real))
