function[u,x,t]= CalorExplND(alpha,ci,L,nx,Tmax,nt) 
% Metodo explicito para la ecuaciondel calor con condiciones Dirichlet 
% Inicializacion 
h=L/nx;  x=0:h:L; 
k=Tmax/nt;  t=0:k:Tmax; 
cix=feval(ci,x); 
u=zeros(nx+1,nt+1); 
u(:,1)=cix'; 
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
    u(1,j+1)=2*lambda*u(2,j)+(1-2*lambda)*u(1,j)+k*exp(-t(j)); 
    u(C,j+1)=lambda*(u(L,j)+u(R,j))+(1-2*lambda)*u(C,j)+k*exp(-t(j)); 
    u(nx+1,j+1)=2*lambda*u(nx,j)+(1-2*lambda*(1+h))*u(nx+1,j)+k*exp(-t(j)); 
end 
end