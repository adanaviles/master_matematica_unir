% Ejemplo 1
alpha=1;
ci=@(x) sin(pi*x); h1=@(x) 0; h2=@(x) 0;
L=1; nx=10;
Tmax=0.5; nt=0.5/0.01;
[u,x,t] = CalorImpl(alpha,ci,h1,h2,L,nx,Tmax,nt);
Sol=@(x,t) exp(-pi^2*t).*sin(pi*x);
SolExacta=Sol(x,0.5)';
[x' u(:,end) SolExacta abs(u(:,end)-SolExacta)];

% Ejemplo 2
alpha=1;
ci=@(x) sin(pi*x); h1=@(x) 0; h2=@(x) 0;
L=1; nx=10;
Tmax=0.5; nt=0.5/0.01;
[u,x,t] = CalorCN(alpha,ci,h1,h2,L,nx,Tmax,nt);
Sol=@(x,t) exp(-pi^2*t).*sin(pi*x);
SolExacta=Sol(x,0.5)';
[x' u(:,end) SolExacta abs(u(:,end)-SolExacta)];

% Ejemplo 3
alpha=1;
ci=@(x) 1-x;
L=1; nx=10;
Tmax=1; nt=1/0.0005;
[u,x,t] = CalorCN_Ejem3(alpha,ci,L,nx,Tmax,nt);
[x' u(:,501) u(:,1001) u(:,1501) u(:,end)];

% Ejercicio 1
alpha=2/pi;
ci=@(x) sin(pi*x/4).*(1+2*cos(pi*x/4)); h1=@(x) 0; h2=@(x) 0;
L=4; nx=10;
Tmax=pi^2; nt=50;
[u,x,t] = CalorImpl(alpha,ci,h1,h2,L,nx,Tmax,nt);
Sol=@(x,t) exp(-t).*sin(pi*x/2)+exp(-t/4).*sin(pi*x/4);
SolExacta=Sol(x,pi^2)';
[x' u(:,end) abs(u(:,end)-SolExacta)];

% Ejercicio 2
alpha=1/sqrt(8*pi^2);
ci=@(x) cos(2*pi*x); h1=@(t) exp(-t/2); h2=@(t) exp(-t/2);
L=1; nx=10;
Tmax=pi^2/4; nt=25;
[u,x,t] = CalorImpl(alpha,ci,h1,h2,L,nx,Tmax,nt);
Sol=@(x,t) exp(-t/2).*cos(2*pi*x);
SolExacta=Sol(x,pi^2/4)';
[x' u(:,end) abs(u(:,end)-SolExacta)];

% Ejercicio 3
alpha=1;
ci=@(x) 0;  h2=@(t) sin(t);
L=1; nx=10;
Tmax=1; nt=100;
[u,x,t] = CalorImpl_Ej2(alpha,ci,h2,L,nx,Tmax,nt);
Sol=@(x,t) sin(x.*t);
SolExacta=Sol(x,1)';
[x' u(:,end) abs(u(:,end)-SolExacta)]
plot(x,u(:,21))
hold on
plot(x,u(:,41))
plot(x,u(:,61))
plot(x,u(:,81))
plot(x,u(:,101))
xlabel('x')
ylabel('u(x,t)')
legend('t=0.2','t=0.4','t=0.6','t=0.8','t=1')
hold off

% Ejercicio 4
%(a)
alpha=1;
ci=@(x) sin(pi*x)+x.*(1-x); h1=@(t) 0; h2=@(t) 0;
L=1; nx=10;
Tmax=1; nt=1/0.05;
[u,x,t] = CalorImpl_Ejer4(alpha,ci,h1,h2,L,nx,Tmax,nt);
Sol=@(x,t) exp(-pi^2*t)+x.*(1-x);
SolExacta=Sol(x,1)';
[x' u(:,end) abs(u(:,end)-SolExacta)];

%(b)
alpha=1;
ci=@(x) sin(pi*x)+x.*(1-x); h1=@(t) 0; h2=@(t) 0;
L=1; nx=10;
Tmax=1; nt=1/0.05;
[u,x,t] = CalorCN_Ejer4(alpha,ci,h1,h2,L,nx,Tmax,nt);
Sol=@(x,t) exp(-pi^2*t)+x.*(1-x);
SolExacta=Sol(x,1)';
[x' u(:,end) abs(u(:,end)-SolExacta)];

% Ejemplo 6
alpha=1;
ci=@(x) 1; h2=@(x) 1;
L=1; nx=10;
Tmax=1.5; nt=1.5/0.01;
[u,x,t] = CalorImpl_Ejer6(alpha,ci,h2,L,nx,Tmax,nt);
[u2,x2,t2] = CalorCN_Ejer6(alpha,ci,h2,L,nx,Tmax,nt);
[x' u(:,end) u2(:,end)];
