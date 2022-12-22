function [u,x,t] = CalorExpl_Ej8(alpha,ci,h2,L,nx,Tmax,nt) 
% Metodo explicito para la ecuacion del calor con condiciones Dirichlet 
% Inicializacion 
h=L/nx;  x=0:h:L; 
k=Tmax/nt;  t=0:k:Tmax; 
cix=feval(ci,x);
c2t=feval(h2,t); 
u=zeros(nx+1,nt+1); 
u(:,1)=cix';
u(nx+1,:)=c2t; 

% Condicion de estabilidad/convergencia 
lambda=k*alpha^2/h^2; 
if lambda>1/2 
    disp('No se cumple el criterio de convergencia') 
else 
    disp('sin problema') 
end 
L=1:nx-1;
C=2:nx;
R=3:nx+1; 
for j=1:nt 
    u(1,j+1)=(1-2*lambda-2*h*lambda)*u(1,j)+2*lambda*u(2,j); 
    u(C,j+1)=(1-2*lambda)*u(C,j)+lambda*(u(L,j)+u(R,j)); 
end 
end