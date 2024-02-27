function [u,x,t] = CalorExpl_Ej6(alpha,ci,h1,h2,L,nx,Tmax,nt) 
% Metodo explicito para la ecuacion del calor con condiciones Dirichlet 
% Inicializacion 
h=L/nx; x=0:h:L;
k=Tmax/nt; t=0:k:Tmax; 
cix=feval(ci,x);
c1t=feval(h1,t); 
c2t=feval(h2,t);
u=zeros(nx+1,nt+1);
u(1,:)=c1t; u(nx+1,:)=c2t; 
u(:,1)=cix'; 
% Por si las condiciones iniciales y de contorno no son consistentes
u(1,1)=(c1t(1)+cix(1))/2; 
u(end,1)=(c2t(1)+cix(end))/2; 
% Condicion de estabilidad/convergencia
lambda=k*alpha^2/h^2; 
if lambda>1/2 
    disp('No se cumple el criterio de convergencia') 
else 
    disp('sin problema') 
end
for j=1:nt 
    for i=2:nx 
        u(i,j+1)=(1-2*lambda)*u(i,j)+lambda*(u(i+1,j)+u(i-1,j))+2*k; 
    end 
end 
end