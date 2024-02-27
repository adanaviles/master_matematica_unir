% Ejemplo 1
alpha=1;
ci=@(x) sin(pi*x); h1=@(x) 0; h2=@(x) 0;
L=1; nx=10;
Tmax=0.03; nt=12;
[u,x,t6b] = CalorExpl(alpha,ci,h1,h2,L,nx,Tmax,nt);
[x' u(:,end)];

% Ejemplo 2
%(a)
alpha=1;
ci=@(x) sin(pi*x); h1=@(x) 0; h2=@(x) 0;
L=1; nx=10;
Tmax=0.5; nt=1000;
[u,x,t6b] = CalorExpl(alpha,ci,h1,h2,L,nx,Tmax,nt); 
Sol=@(x,t) exp(-pi^2*t).*sin(pi*x);
SolExacta=Sol(x,0.5)';
[x' u(:,end) abs(u(:,1001)-SolExacta)];
%(b)
alpha=1;
ci=@(x) sin(pi*x); h1=@(x) 0; h2=@(x) 0;
L=1; nx=10;
Tmax=0.5; nt=50;
[u,x,t6b] = CalorExpl(alpha,ci,h1,h2,L,nx,Tmax,nt); 
Sol=@(x,t) exp(-pi^2*t).*sin(pi*x);
SolExacta=Sol(x,0.5)';
[x' u(:,end) abs(u(:,51)-SolExacta)];

% Ejemplo 3
[u,x,t6b]=CalorExplND(1,@(x)1-x,1,10,1,2000);

% Ejercicio 1
alpha=2/pi;
ci=@(x) sin(pi*x/4).*(1+2*cos(pi*x/4)); h1=@(x) 0; h2=@(x) 0;
L=4; nx=10;
Tmax=pi^2; nt=50;
[u,x,t6b] = CalorExpl(alpha,ci,h1,h2,L,nx,Tmax,nt);
Sol=@(x,t) exp(-t).*sin(pi*x/2)+exp(-t/4).*sin(pi*x/4);
SolExacta=Sol(x,pi^2)';
[x' u(:,end) abs(u(:,end)-SolExacta)];

% Ejercicio 2
alpha=1/sqrt(8*pi^2);
ci=@(x) cos(2*pi*x); h1=@(t) exp(-t/2); h2=@(t) exp(-t/2);
L=1; nx=10;
Tmax=pi^2/4; nt=25;
[u,x,t6b] = CalorExpl(alpha,ci,h1,h2,L,nx,Tmax,nt);
Sol=@(x,t) exp(-t/2).*cos(2*pi*x);
SolExacta=Sol(x,pi^2/4)';
[x' u(:,end) abs(u(:,end)-SolExacta)];

% Ejercicio 3
alpha=sqrt(2);
ci=@(x) x.^2; h1=@(t) 4*t; h2=@(t) 1+4*t;
L=1; nx=5;
Tmax=1; nt=100;
[u,x,t6b] = CalorExpl_Ejer3(alpha,ci,h1,h2,L,nx,Tmax,nt);
Sol=@(x,t) 4*t+x.^2;
SolExacta=Sol(x,1)';
[x' u(:,end) abs(u(:,end)-SolExacta)];
surf(u)

% Ejercicio 4
%(a) k=0.1
alpha=sqrt(1/8);
ci=@(x) x.*(x-1); h2=@(t) sin(2*pi*t);
L=1; nx=10;
Tmax=1; nt=10;
[u,x,t6b]= CalorExplND_Ejer4(alpha,ci,h2,L,nx,Tmax,nt); 
Sol=@(x,t) x.*(x-1)+sin(2*pi*t);
SolExacta=Sol(x,1)';
[x' u(:,end) abs(u(:,end)-SolExacta)];

%(a) k=0.01
alpha=sqrt(1/8);
ci=@(x) x.*(x-1); h2=@(t) sin(2*pi*t);
L=1; nx=10;
Tmax=1; nt=100;
[u,x,t6b]= CalorExplND_Ejer4(alpha,ci,h2,L,nx,Tmax,nt); 
Sol=@(x,t) x.*(x-1)+sin(2*pi*t);
SolExacta=Sol(x,1)';
[x' u(:,end) abs(u(:,end)-SolExacta)];
surf(u)

% Ejercicio 5
alpha=1;
ci=@(x) sin(x)+cos(x); h1=@(t) 2*t; h2=@(t) t.^2/2;
L=1; nx=10;
Tmax=0.5; nt=1000;
[u,x,t6b]= CalorExplND_Ejer5(alpha,ci,h1,h2,L,nx,Tmax,nt); 
[x' u(:,end)];

% Ejercicio 6
%(a)
alpha=1;
ci=@(x) sin(pi*x)+x.*(1-x); h1=@(x) 0; h2=@(x) 0;
L=1; nx=10;
Tmax=1; nt=20;
[u6,x6,t6] = CalorExpl_Ej6(alpha,ci,h1,h2,L,nx,Tmax,nt);
Sol=@(x,t) exp(-pi^2*t).*sin(pi*x)+x.*(1-x);
SolExacta6=Sol(x6,1)';
[x6' u6(:,end) abs(u6(:,end)-SolExacta6)];

%(b)
alpha=1;
ci=@(x) sin(pi*x)+x.*(1-x); h1=@(x) 0; h2=@(x) 0;
L=1; nx=10;
Tmax=1; nt=1000;
[u6b,x6b,t6b] = CalorExpl_Ej6(alpha,ci,h1,h2,L,nx,Tmax,nt);
Sol=@(x,t) exp(-pi^2*t).*sin(pi*x)+x.*(1-x);
SolExacta6b=Sol(x6b,1)';
[x6b' u6b(:,end) abs(u6b(:,end)-SolExacta6b)];

% Ejercicio 7
alpha=1;
ci=@(x) 0; h2=@(t) sin(t);
L=1; nx=10;
Tmax=1; nt=100;
[u7,x7,t7] = CalorExpl_Ej7(alpha,ci,h2,L,nx,Tmax,nt);
Sol=@(x,t) sin(x.*t);
SolExacta7=Sol(x7,1)';
[x7(3:2:end)' u7(3:2:end,end) abs(u7(3:2:end,end)-SolExacta7(3:2:end))];

% Ejercicio 8
alpha=1;
ci=@(x) 1; h2=@(t) 1;
L=1; nx=10;
Tmax=1.5; nt=1500;
[u8,x8,t8] = CalorExpl_Ej8(alpha,ci,h2,L,nx,Tmax,nt);
[x8' u8(:,end)];

% Ejercicio 9
alpha=1;
ci=@(x) sin(x)+cos(x); h1=@(t) 2*t; h2=@(t) t.^2/2;
L=1; nx=10;
Tmax=0.5; nt=1000;
[u,x,t6b]= CalorExpl_Ej9(alpha,ci,h1,h2,L,nx,Tmax,nt); 
[x' u(:,end)]

% Ejercicio 10
%(b)
alpha=1;
ci=@(x) sin(pi*x).*x.^2; h1=@(x) 0; h2=@(x) 0;
L=1; nx=10;
Tmax=2; nt=400;
[u10,x10,t10] = CalorExpl_Ej10(alpha,ci,h1,h2,L,nx,Tmax,nt);
%(c)
alpha=1;
ci=@(x) exp(sin(pi*x).*x.^2); h1=@(x) 1;h2=@(x) 1;
L=1; nx=10;
Tmax=2; nt=400;
[u10c,x10c,t10c] = CalorExpl(alpha,ci,h1,h2,L,nx,Tmax,nt);
[x10' u10(:,end) x10c' u10c(:,end)]