% Ejemplo 7
[nodos, solAprox,t, iter]=disparo_secante('ejemplo1_7',1,3,17,43/3,19,1e-5,50)

% Ejemplo 9
[nodos, solAprox,t, iter]=disparo_Newton('ejemplo1_9',1,3,17,43/3,19,1e-5,50)

% Ejemplo 3
[X,Y,iter,incr]= Difnolin(@(x,y,z) (32+2*x.^3-y.*z)/8', ...
    @(x,y,z) (-1)*z/8,@(x,y,z) (-1)*y/8,1,3,17,43/3,19,50,1e-5);
SolExacta=X.^2+16./X;
[X Y SolExacta abs(Y-SolExacta)];

% Ejemplo 1
alpha=2;
CI1=@(x) sin(pi*x); CI2=@(x) 0*x;
CC1=@(t) 0*t; CC2=@(t) 0*t;
a=0; b=1; nx=10;
Tmax=1; nt=1/0.05;
[U,x,t] = explicitoOndas(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha); 
Sol=@(x,t) sin(pi*x).*cos(2*pi*t);

% Ejemplo 3
alpha=1;
CI1=@(x) 2-abs(x-2); CI2=@(x) 0*x;
CC1=@(t) 0*t; CC2=@(t) 0*t;
a=0; b=4; nx=4;
Tmax=4; nt=4/0.5;
[U,x,t] = implicitoOndas(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha); 
table(t',U');