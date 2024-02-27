% Ejemplo 1
p=@(x) 1+0.*x;
q=@(x) pi^2+0.*x;
f=@(x) 2*pi^2.*sin(pi.*x);
m=3; a=0; b=1; h=(b-a)/(m+1); t=a:h:1;
c=RRlin(p,q,f,t,m);
Exacta=@(x) sin(pi.*x);
y=Exacta(t)';
phi=[0; c; 0];
dif=abs(y-phi);
table(t', phi,y,dif);

% Ejercicio 1
p=@(x) 1+0.*x;
q=@(x) 2+0.*x;
f=@(x) -4+exp(-x)-2*x/exp(1)+2*x.^2;
m=9; a=0; b=1; h=(b-a)/(m+1); t=a:h:1;
c=RRlin(p,q,f,t,m);
phi=[0; c; 0];
table(t', phi);

% Ejercicio 2
%Ejercicio2

% Ejercicio 3
p=@(x) 1+0.*x;
q=@(x) 1+0.*x;
f=@(x) (1-exp(-1)).*x-1;
m=10; a=0; b=1; h=(b-a)/(m+1); t=a:h:1;
c=RRlin(p,q,f,t,m);
phi=[0; c; 0];
Exacta=@(x) x+exp(-x)-(1+exp(-1)).*x-(1-x);
y=Exacta(t)';
dif=abs(y-phi);
table(t', phi,y,dif);

% Ejercicio 4
p=@(x) x;
q=@(x) 4+0.*x;
f=@(x) 4.*x.^2-8*x+1;
m=20; a=0; b=1; h=(b-a)/(m+1); t=a:h:1;
c=RRlin(p,q,f,t,m);
phi=[0; c; 0];
Exacta=@(x) x.^2-x;
y=Exacta(t)';
phi=[0; c; 0];
dif=abs(y-phi);
table(t', phi,y,dif);

% Ejercicio 5
p=@(x) exp(x);
q=@(x) exp(x);
f=@(x) x+(2-x).*exp(x);
m=10; a=0; b=1; h=(b-a)/(m+1); t=a:h:1;
c=RRlin(p,q,f,t,m);
phi=[0; c; 0];
Exacta=@(x) (x-1).*(exp(-x)-1);
y=Exacta(t)';
phi=[0; c; 0];
dif=abs(y-phi);
table(t', phi,y,dif);

