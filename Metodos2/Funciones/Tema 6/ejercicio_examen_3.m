alpha=1;
ci=@(x) cos(x*pi);
h2=@(t) -exp(-(pi^2)*t);
L=1;
nx=100;
Tmax=0.2;
nt=20;
[u,x,t] = CalorImpl_Ej2(alpha,ci,h2,L,nx,Tmax,nt);
plot(x,u(:,1))


function [u,x,t] = Calor_examen(alpha,ci,h2,L,nx,Tmax,nt) 
% Metodo explicito para la ecuacion del calor con condiciones Dirichlet 
% Inicializacion 
h=L/nx;
x=0:h:L;
k=Tmax/nt;
t=0:k:Tmax; 
cix=feval(ci,x); 
c2t=feval(h2,t);
u=zeros(nx+1,nt+1);
u(nx+1,:)=c2t; 
u(:,1)=cix'; 
% Por si las condiciones iniciales y de contorno no son consistentes
u(end,1)=(c2t(1)+cix(end))/2; 
% Condicion de estabilidad/convergencia
lambda=k*alpha^2/h^2; 
% if lambda>1/2 
%     disp('No se cumple el criterio de convergencia') 
% else 
%     disp('sin problema') 
% end

dp=(1+lambda)*ones(nx,1);
ds=(-lambda/2)*ones(nx-1,1);
ds(1)=-lambda;
di=(-lambda/2)*ones(nx-1,1);

dpB=(1-lambda)*ones(nx,1);
dsB=(lambda/2)*ones(nx-1,1);
dsB(1)=lambda;
diB=(lambda/2)*ones(nx-1,1);
B=diag(dpB,0)+diag(dsB,1)+diag(diB,-1);
for j=2:nt+1 
    d=B*u(1:nx,j-1);
    d(1)=d(1)-4*h*(lambda/2+lambda*h/4)*(t(j)+t(j-1));
    d(end)=d(end)+(lambda/2-lambda*h/4)*(u(nx+1,j)+u(nx+1,j-1));
    z=Crout(dp,ds,di,d);
    u(1:nx,j)=z;
end 
end