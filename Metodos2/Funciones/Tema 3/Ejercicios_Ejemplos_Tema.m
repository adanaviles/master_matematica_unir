% Ejemplo 1
[x,y] = DiFiLineal(@(x) -2./x,@(x) 2./x.^2,@(x) sin(log(x))./x.^2,1,2,1,2,9);
c1=(69+4*cos(log(2))+12*sin(log(2)))/70;
c2=4/35-2*cos(log(2))/35-6*sin(log(2))/35;
SolExacta=c1.*x+c2./(x.^2)-3*sin(log(x))./10-cos(log(x))./10;
[x y SolExacta abs(y-SolExacta)];

% Ejemplo 2
[r,u] = DiFiLineal_Ej2();
SolExacta=(log(r'/3)-0.5*log(r'))/log(1/3);
[r' u SolExacta abs(u-SolExacta)];

% Ejemplo 3
[X,Y,iter,incr]= Difnolin(@(x,y,z) (32+2*x.^3-y.*z)/8', ...
    @(x,y,z) (-1)*z/8,@(x,y,z) (-1)*y/8,1,3,17,43/3,19,50,1e-5);
SolExacta=X.^2+16./X;
[X Y SolExacta abs(Y-SolExacta)];

% Ejemplo 4
f=@(x,y,z) -cos(pi*x).*((z-1).^2+pi^2*(y-x).^2); 
fy=@(x,y,z) -2*pi^2*cos(pi*x).*(y-x); 
fz=@(x,y,z) -2*cos(pi*x).*(z-1);
[X,Y,iter,incr]= Difnolin(f,fy,fz, 0,1,1,0,9,50,1e-5);
SolExacta2=X+cos(pi*X);
[X Y SolExacta2 abs(Y-SolExacta2)];

% Ejercicio 1
% a)
[x,y]=disparo_lineal('pvi','pvi',2,4,110,0,20);
[x2,y2]=disparo_lineal('pvi','pvi',2,4,110,0,40);
Sol=@(x) 110*2./x.*(4-x)/2;
[x y(:,1) Sol(x) abs(y(:,1)-Sol(x))];
[x2 y2(:,1) Sol(x2) abs(y2(:,1)-Sol(x2))];
% b)
[x3,y3] = DiFiLineal(@(x) -2./x,@(x) 0.*x,@(x) 0.*x,2,4,110,0,20);
[x4,y4] = DiFiLineal(@(x) -2./x,@(x) 0.*x,@(x) 0.*x,2,4,110,0,40);
[x3 y3(:,1) Sol(x3) abs(y3(:,1)-Sol(x3))];
[x4 y4(:,1) Sol(x4) abs(y4(:,1)-Sol(x4))];
z=2:0.01:4;
plot(z,Sol(z))
hold on
plot(x,y(:,1),'o')
plot(x2,y2(:,1),'o')
plot(x3,y3(:,1),'x')
plot(x4,y4(:,1),'x')
grid on
legend('Exacta', 'Disparo N=20', 'Disparo N=40', 'DF N=20', 'DF N=40')
hold off


% Ejercicio 2
% (a)
f=@(x,y,z) -z.^2-y+log(x); 
fy=@(x,y,z) -1+0.*x.*y.*z; 
fz=@(x,y,z) -2.*z+0.*x.*y;
[X2,Y2,iter,incr]= Difnolin(f,fy,fz,1,2,0,log(2),19,100,1e-8);
SolExacta3=log(X2);
[X2 Y2 SolExacta3 abs(Y2-SolExacta3)];

% (b)
f=@(x,y,z) y.^3-y.*z; 
fy=@(x,y,z) -3.*y.^2-z+0.*x; 
fz=@(x,y,z) -y+0.*x.*y.*z;
[X2b,Y2b,iter,incr]= Difnolin(f,fy,fz,1,2,1/2,1/3,19,100,1e-8);
SolExacta3b=1./(1+X2b);
[X2b Y2b SolExacta3b abs(Y2b-SolExacta3b)];

% (c)
f=@(x,y,z) 2*y.^3-6*y-2*x.^3; 
fy=@(x,y,z) 6.*y.^2-6+0.*x.*y.*z; 
fz=@(x,y,z) 0.*x.*y.*z;
[X2c,Y2c,iter,incr]= Difnolin(f,fy,fz,1,2,2,5/2,19,100,1e-8);
SolExacta3c=X2c+1./(X2c);
[X2c Y2c SolExacta3c abs(Y2c-SolExacta3c)];

% Ejercicio 3
f=@(x,y,z) x.*y.*z-x.*cos(x).*y-sin(x); 
fy=@(x,y,z) x.*z-x.*cos(x); 
fz=@(x,y,z) x.*y;
[X3,Y3,iter,incr]= Difnolin3(f,fy,fz,0,pi,1,2,19,50,1e-8);
SolExacta3=sin(X3);
[X3 Y3 SolExacta3 abs(Y3-SolExacta3)]

% Ejercicio 5
f=@(x,y,z,w) -6*z.^2-w+2*y.^3; 
fy=@(x,y,z,w) 6*y.^2; 
fz=@(x,y,z,w) -12*z;
fw=@(x,y,z,w) -1;
[X5,Y5,iter,incr]= Difnolin5(f,fy,fz,fw,-1,0,1/2,1/3,-1/9,8,100,1e-5)
SolExacta5=1./(X5+3);
[X5 Y5 SolExacta5 abs(Y5-SolExacta5)]