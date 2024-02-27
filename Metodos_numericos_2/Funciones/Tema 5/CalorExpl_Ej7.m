function [u,x,t] = CalorExpl_Ej7(alpha,ci,h2,L,nx,Tmax,nt) 
% Metodo explicito para la ecuacion del calor con condiciones Dirichlet 
% Inicializacion 
h=L/nx; x=0:h:L;
k=Tmax/nt; t=0:k:Tmax; 
cix=feval(ci,x); 
c2t=feval(h2,t);
u=zeros(nx+1,nt+1);
u(nx+1,:)=c2t; 
u(:,1)=cix'; 
% Por si las condiciones iniciales y de contorno no son consistentes 
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
        u(i,1)=h*t(1)+u(i-1,1);
        u(i,j+1)=(1-2*lambda+k*t(j).^2)*u(i,j)+lambda*(u(i+1,j)+u(i-1,j))+k*x(i)*cos(x(i)-t(j)); 
    end 
end 
end