% Ejemplo 1
A=[10 -1 2 0; -1 11 -1 3; 2 -1 10 -1; 0 3 -1 8];
b=[6;25;-11;15];
x0=[0;0;0;0];
tol=1e-3;
maxiter=100;
[x, iter]=Jacobi(A,b,x0, tol,maxiter);

% Ejemplo 2
A=[10 -1 2 0; -1 11 -1 3; 2 -1 10 -1; 0 3 -1 8];
b=[6;25;-11;15];
x0=[0;0;0;0];
tol=1e-3;
maxiter=100;
[x, iter]=Gauss_Seidel(A,b,x0, tol,maxiter);

% Ejemplo 3
A=[4 3 0;3 4 -1; 0 -1 4];
b=[24 30 -24]';
x0=[0 0 0]';
tol=1e-7;
maxiter=100;
[x, iter]=Gauss_Seidel(A,b,x0, tol,maxiter);
w=1.25;
[x, iter]=SOR(w,A,b,x0, tol,maxiter);

% Ejemplo 5
f0=@(x) x;
f1=@(x) x.*exp(1);
g0=@(y) 0*y;
g1=@(y) 2*exp(y);
a=0;b=2;
c=0; d=1;
nx=6; ny=5;
funcionti= @(x,y) x.*exp(y);
maxiter=100; tol=1e-10;
[U,incre,iter,x,y]=ElipticaGaussSeidel(f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol);
solExacta=@(x,y) x.*exp(y);
uExacta=feval(solExacta,x,y');
dif=abs(U-uExacta);

% Ejemplo 6
f0=@(x) 1*ones(1,length(x));
f1=@(x) 0.*x;
a=-1;b=1;
c=-1; d=1;
nx=8; ny=8;
funcionti= @(x,y) 0;
maxiter=200; tol=1e-5;
[U,incre,iter,x,y]=ElipticaGaussSeidel_Ejem6(f0,f1,a,b,c,d,nx,ny,funcionti,maxiter,tol);

% Ejercicio 1
f0=@(x) cos(2*x);
f1=@(x) cos(2*x)+sin(2);
g0=@(y) sin(2*y)+1;
g1=@(y) sin(2*y)+cos(2);
a=0;b=1;
c=0; d=1;
nx=5; ny=10;
funcionti= @(x,y) 0;
maxiter=200; tol=1e-5;
solExacta=@(x,y) sin(2*y)+cos(2*x);
uExacta=feval(solExacta,x,y');
[U,incre,iter,x,y]=ElipticaSOR_Ej1(0.2,f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol);
uExacta=feval(solExacta,x,y');
dif1=max(max(abs(U-uExacta)));
[U,incre,iter,x,y]=ElipticaSOR_Ej1(0.4,f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol); 
uExacta=feval(solExacta,x,y');
dif2=max(max(abs(U-uExacta)));
[U,incre,iter,x,y]=ElipticaSOR_Ej1(0.8,f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol); 
uExacta=feval(solExacta,x,y');
dif3=max(max(abs(U-uExacta)));
[U,incre,iter,x,y]=ElipticaSOR_Ej1(1.2,f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol); 
uExacta=feval(solExacta,x,y');
dif4=max(max(abs(U-uExacta)));
[U,incre,iter,x,y]=ElipticaSOR_Ej1(1.6,f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol); 
uExacta=feval(solExacta,x,y');
dif5=max(max(abs(U-uExacta)));
[U,incre,iter,x,y]=ElipticaSOR_Ej1(2,f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol); 
uExacta=feval(solExacta,x,y');
dif6=max(max(abs(U-uExacta)));
Dif=[dif1 dif2 dif3 dif4 dif5 dif6];

% Ejercicio 2
f0=@(x) 0*x;
f1=@(x) x-1;
g0=@(y) sin(y);
g1=@(y) 0*y;
a=1;b=2;
c=0; d=pi;
nx=10; ny=6;
funcionti= @(x,y) -x.^2*sin(2*y);
maxiter=200; tol=1e-8;
w=0.2:0.05:2;
for j=1:length(w)
    [U,incre,iter(j),x,y]=ElipticaSOR_Ej1(w(j),f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol);
end
%plot(w,iter,'o')

% Ejercicio 3
f0=@(x) cos(x);
f1=@(x) 0*x;
g0=@(y) cos(y);
g1=@(y) -cos(y);
a=0;b=pi;
c=0; d=pi/2;
nx=10; ny=5;
funcionti= @(x,y) -cos(x+y)-cos(x-y);
maxiter=200; tol=1e-10;
[U,incre,iter1,x,y]=ElipticaJacobi(f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol);
solExacta=@(x,y) cos(x).*cos(y);
uExacta=feval(solExacta,x,y');
dif=max(max(abs(U-uExacta)));
w=4/(2+sqrt(4-(cos(pi/nx)+cos(pi/ny))^2));
[U,incre,iter2,x,y]=ElipticaSOR(w,f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol) ;
uExacta=feval(solExacta,x,y');
dif=max(max(abs(U-uExacta)));

% Ejercicio 4
%Ejer4

% Ejercicio 5
f0=@(x) 0*x;
f1=@(x) 0*x;
g0=@(y) y.*(1-y);
g1=@(y) y.*(1-y);
a=0;b=1;
c=0; d=1;
nx=10; ny=10;
funcionti= @(x,y) 0.*x.*y;
maxiter=400; tol=1e-10;
[UJ,incre,iterJ,x,y]=ElipticaJacobi(f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol);
[UGS,incre,iterGS,x,y]=ElipticaGaussSeidel(f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol);
w=0.2:0.01:2;
for j=1:length(w)
    [U,incre,iter(j),x,y]=ElipticaSOR(w(j),f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol);
end
% subplot(2,2,1);
% surf(UJ)
% subplot(2,2,2);
% surf(UGS)
% subplot(2,2,3);
% plot(w,iter,'o')
% subplot(2,2,4);
% [US,incre,iter,x,y]=ElipticaSOR(1.53,f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol);
% surf(US)

% Ejercicio 6
%Ejer6

% Ejercicio 7
%Ejer7

% Ejercicio 8
%Ejer8

% Ejercicio 9
%Ejer9


% Ejemplo 10
f0=@(x) 0.*x;
f1=@(x) 0.*x;
a=0;b=pi;
c=0; d=pi;
nx=10; ny=10;
funcionti= @(y,x) sin(y).*sin(x.^2);
maxiter=400; tol=1e-9;
[U,incre,iter,x,y]=ElipticaGaussSeidel_Ejer10(f0,f1,a,b,c,d,nx,ny,funcionti,maxiter,tol);
[U,incre,iter,x,y]=ElipticaJacobi_Ejer10(f0,f1,a,b,c,d,nx,ny,funcionti,maxiter,tol);
solExacta=@(x,y) sin(y).*cos(x.^2);
uExacta=feval(solExacta,x,y');
dif=abs(U-uExacta)