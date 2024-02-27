% Examen pregunta 1
% Apartado A
format long
a=2; b=3
f=@(x) 1./sqrt(x-1)
IntExact = integral(f,a,b)
% Apartado b, utilizar metodo de trapecios y encontrar error
nmtp = 12
I_trap = trapecios(f,a,b,nmtp)
error_trap = abs(IntExact-I_trap)
% Apartado c, utilizar metodo de simpson_3_8 y encontrar error
nmtp = 12
I_simp = simpson38(f,a,b,nmtp)
error_simp = abs(IntExact-I_trap)

%% Ejercicio 2
a=1;
b=2;
N=20;
Ya=[exp(1)+3; 2*exp(1)+9; 4*exp(1)+18];

[t,Y]=Heun('PVI',a,b,N,Ya)

plot(t,Y(:,1))
grid on
xlabel('t')
ylabel('y(t)')

[t Y(:,1)]

[sol ,iter, incre, f_eval, dif , ACOC ]  =OstrowskiNL('ejercicio3',vpa(1.1) ,1e-10 ,50)

function [f, df] = ejercicio3(x)
f= sin(x.^2)+2*x-exp(x);
df= 2*x.*cos(x.^2)+2-exp(x)
end



% eJERCICIO 3

function [sol ,iter, incre, f_eval, dif , ACOC ] =OstrowskiNL(f,x0 ,tol , maxiter )
digits (200);
% Inicializacion de las variables
iter =1; 
[fx, dfx]=feval(f,x0);
% Criterio de parada
incre = 1 + tol ;
while incre > tol && iter < maxiter
    % Expresion del metodo de Newton
    y=x0 -fx/ dfx ;
    [fy, dfy]=feval(f,y);
    x=y-(fx/(fx-2*fy))*(fy/dfx);
    incre1 = abs(x-x0);
    I(iter)= incre1 ;
    % Actualizacion de la estimacion inicial
    dif=(x-x0);
    x0=x;
    [fx , dfx ]= feval(f,x0);
    % Incremento del contador de iteraciones
    iter = iter +1;
    incre=incre1+abs(fx);
end
if length(I) >2
    sol =vpa(x,7);
    incre1=vpa(incre1,7);
    f_eval=vpa(abs(fx),7);
    dif=vpa(abs(dif),7);
    ACOC = vpa(log(I(3 :end)./I(2 :end -1))./ log(I(2 :end -1)./I(1 :end -2)),7);
else
    disp ('necesito mas iteraciones ')
end
end












function dY = PVI(t,y)
    Y1=y(1);
    Y2=y(2);
    Y3=y(3);
    dY=[Y2;Y3;-t.*Y1+18+4.*t.^2.*Y2+t.*exp(t.^2)-33*t.^4];
end






















function I= trapecios (f,a,b,n)
    % I=trapecios(f,a,b,n) obtiene la integral de f(x)
    % con la fórmula de trapecios compuesta.
    h = (b-a)/n;
    x = a:h:b;
    pesos = [1 2* ones(1,n -1) 1];
    I=h /2* sum ( pesos.*f(x));
end

function I= simpson38(f,a,b,n)
    % I=simpson(f,a,b,n) obtiene la integral de f(x)
    % con la fórmula de Simpson compuesta.
    h = (b-a)/n;
    x = a:h:b;
    pesos = ones (1,n +1) ;
    pesos (2:3: n) = 3; pesos (3:3: n) = 3; pesos (4:3:n -1) = 2;
    I=3*h /8* sum ( pesos.*f(x));
end

function [t,Y]=Heun(f,a,b,N,Ya)
%Codigo para resolver un PVI con el método de Euler
h=(b-a)/N;
t=a:h:b;
t=t(:);
Y=zeros(N+1,length(Ya));
Y(1,:)=Ya;
for k=1:N
    k1=h*feval(f,t(k),Y(k,:))';
    k2=h*feval(f,t(k+1),Y(k,:)+k1)';
    Y(k+1,:)=Y(k,:)+k1/2+k2/2;
end
end
