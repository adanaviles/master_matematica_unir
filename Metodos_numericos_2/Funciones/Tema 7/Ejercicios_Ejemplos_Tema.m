% Ejemplo 1
% (a)
alpha=2;
CI1=@(x) sin(pi*x); CI2=@(x) 0*x;
CC1=@(t) 0*t; CC2=@(t) 0*t;
a=0; b=1; nx=10;
Tmax=1; nt=1/0.05;
[U,x,t] = explicitoOndas(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha); 
Sol=@(x,t) sin(pi*x).*cos(2*pi*t);
% (b)
Tmax=1; nt=1/0.1;
[U2,x2,t2] = explicitoOndas(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha); 
Sol=@(x,t) sin(pi*x).*cos(2*pi*t);
SolExacta=Sol(x,1);
SolExacta2=Sol(x2,1);
Aprox=U(:,end);
Aprox2=U2(:,end);
Error=abs(U(:,end)-SolExacta);
Error2=abs(U2(:,end)-SolExacta2);
table(x, Aprox, Error, Aprox2, Error2);

% Ejemplo 2
% (a)
alpha=1;
CI1=@(x) sin(pi*x); CI2=@(x) 0*x;
CC1=@(t) 0*t; CC2=@(t) 0*t;
a=0; b=1; nx=10;
Tmax=1; nt=1/0.0005;
[U,x,t] = explicitoOndas_Ej2(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha);
table(x,U(:,end));
% plot(x,U(:,501))
% hold on
% plot(x,U(:,1001))
% plot(x,U(:,1501))
% hold off

% Ejemplo 3
alpha=1;
CI1=@(x) 2-abs(x-2); CI2=@(x) 0*x;
CC1=@(t) 0*t; CC2=@(t) 0*t;
a=0; b=4; nx=4;
Tmax=4; nt=4/0.5;
[U,x,t] = implicitoOndas(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha); 
table(t',U');

% Ejemplo 4
alpha=1;
CI1=@(x) sin(pi*x); CI2=@(x) 0*x;
CC1=@(t) 0*t; CC2=@(t) 0*t;
a=0; b=1; nx=10;
Tmax=0.5; nt=0.5/0.005;
[U,x,t]=explicitoTelegrafo(CC1,CC2,CI1,CI2,a,b,Tmax,nx,nt,alpha); 
[U2,x2,t2]=implicitoTelegrafo(CC1,CC2,CI1,CI2,a,b,Tmax,nx,nt); 
%plot(x,U(:,21),x,U(:,41),x,U(:,61),x,U(:,81),x,U(:,101))
x_i=x';
Explicito=U(:,end);
Implicito=U2(:,end);
table(x_i,Explicito,Implicito);


% Ejemplo 5
alpha=1;
CI1=@(x) 3*sin(x)+1; CI2=@(x) -1*ones(length(x),1);
CC1=@(t) exp(-t);
a=0; b=pi; nx=10;
Tmax=1.5; nt=100;
[U,x,t] = explicitoOndas_Ej5(CC1,CI1,CI2,a,b,nx,nt,Tmax,alpha);
[U2,x2,t2] = implicitoOndas_Ej5(CC1,CI1,CI2,a,b,nx,nt,Tmax,alpha);
table(x,U(:,end),U2(:,end));
%plot(U)

% Ejercicio 1
alpha=1;
CI1=@(x) sin(pi*x); CI2=@(x) 0*x;
CC1=@(t) 0*t; CC2=@(t) 0*t;
a=0; b=1; nx=10;
Tmax=1; nt=1/0.0005;
[U,x,t] = explicitoOndas_Ejer1(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha); 
[U2,x2,t2] = implicitoOndas_Ejer1(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha);
dif=abs(U(:,end)-U2(:,end));
table(x,U(:,end),U2(:,end),dif);

% Ejercicio 2
alpha=1;
CI1=@(x) 3*sin(x); CI2=@(x) 0*x;
CC1=@(t) 0*t; CC2=@(t) 0*t;
a=0; b=pi; nx=10;
Tmax=2; nt=5;
[U,x,t] = explicitoOndas(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha); 
[U2,x2,t2] = implicitoOndas(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha);
dif=abs(U(:,end)-U2(:,end));
table(x,U(:,end),U2(:,end),dif);

% Ejercicio 3
alpha=1;
CI1=@(x) sin(pi*x); CI2=@(x) 0*x;
CC1=@(t) 0*t; CC2=@(t) 0*t;
a=0; b=1; nx=10;
Tmax=1.5; nt=1000;
[U,x,t] = explicitoOndas_Ejer3(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha); 
[U2,x2,t2] = implicitoOndas_Ejer3(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha);
dif=abs(U(:,end)-U2(:,end));
Expl=U(:,end);
Impl=U2(:,end);
table(x,Expl,Impl,dif);

% Ejercicio 4
alpha=1;
CI1=@(x) sin(pi*x); CI2=@(x) 0*x;
CC1=@(t) 0*t; CC2=@(t) 0*t;
a=0; b=1; nx=10;
Tmax=1.5; nt=1000;
[U,x,t] = explicitoOndas_Ejer4(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha); 
[U2,x2,t2] = implicitoOndas_Ejer4(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha);
dif=abs(U(:,end)-U2(:,end));
table(x,U(:,end),U2(:,end),dif);

% Ejercicio 5
alpha=1;
CI1=@(x) sin(pi*x); CI2=@(x)x-2*x.^2;
CC1=@(t) 0*t; CC2=@(t) 2*t;
a=0; b=1; nx=10;
Tmax=1.5; nt=100;
[U,x,t] = explicitoOndas_Ejer5(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha); 
[U2,x2,t2] = implicitoOndas_Ejer5(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha);
dif=abs(U(:,end)-U2(:,end));
table(x,U(:,end),U2(:,end),dif);

% Ejercicio 6
alpha=1;
CI1=@(x) cos(x); CI2=@(x)x.^2-2*x;
CC1=@(t) 0*t; CC2=@(t) t.^2;
a=0; b=1; nx=10;
Tmax=1; nt=1/0.0005;
[U,x,t] = explicitoOndas_Ejer6(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha); 
[U2,x2,t2] = implicitoOndas_Ejer6(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha);
dif=abs(U(:,end)-U2(:,end));
table(x,U(:,end),U2(:,end),dif);

% Ejercicio 7
alpha=1;
CI1=@(x) x.*(x-1); CI2=@(x) 1*ones(length(x),1);
a=0; b=1; nx=10;
Tmax=1; nt=1/0.0005;
[U,x,t] = explicitoOndas_Ejer7(CI1,CI2,a,b,nx,nt,Tmax,alpha); 
[U2,x2,t2] = implicitoOndas_Ejer7(CI1,CI2,a,b,nx,nt,Tmax,alpha);
dif=abs(U(:,end)-U2(:,end));
Expl=U(:,end);
Impl=U2(:,end);
table(x,Expl,Impl,dif)

% Ejercicio 8
alpha=1;
CI1=@(x) (1-x).*x/2; CI2=@(x)0*x;
CC1=@(t) 0*t;
a=0; b=1; nx=10;
Tmax=1; nt=1/0.0005;
[U,x,t] = explicitoOndas_Ejer8(CC1,CI1,CI2,a,b,nx,nt,Tmax,alpha); 
[U2,x2,t2] = implicitoOndas_Ejer8(CC1,CI1,CI2,a,b,nx,nt,Tmax,alpha);
dif=abs(U(:,end)-U2(:,end));
table(x,U(:,end),U2(:,end),dif);

% Ejercicio 9
alpha=1;
CI1=@(x) 0*x; CI2=@(x)sin(pi*x);
a=0; b=1; nx=10;
Tmax=1; nt=1/0.0005;
[U,x,t] = explicitoOndas_Ejer9(CI1,CI2,a,b,nx,nt,Tmax,alpha); 
[U2,x2,t2] = implicitoOndas_Ejer9(CI1,CI2,a,b,nx,nt,Tmax,alpha);
dif=abs(U(:,end)-U2(:,end));
Expl=U(:,end);
Impl=U2(:,end);
table(x,Expl,Impl,dif);

% Ejercicio 10
alpha=1;
CI1=@(x) 0*x; CI2=@(x)sin(pi*x);
a=0; b=1; nx=10;
Tmax=1; nt=1/0.0005;
[U,x,t] = explicitoOndas_Ejer10(CI1,CI2,a,b,nx,nt,Tmax,alpha); 
[U2,x2,t2] = implicitoOndas_Ejer10(CI1,CI2,a,b,nx,nt,Tmax,alpha);
dif=abs(U(:,end)-U2(:,end));
Expl=U(:,end);
Impl=U2(:,end);
table(x,Expl,Impl,dif);