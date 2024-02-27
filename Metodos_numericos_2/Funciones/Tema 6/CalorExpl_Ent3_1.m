function [u,x,t] = CalorExpl_Ent3_1(alpha,ci,h2,L,nx,Tmax,nt) 
% Metodo explicito para la ecuacion del calor con condiciones Dirichlet 
% Inicializacion 
h=L/nx;  x=0:h:L; 
k=Tmax/nt;  t=0:k:Tmax; 
cix=feval(ci,x);
c2t=feval(h2,t); 
u=zeros(nx+1,nt+1); 
u(:,1)=cix';
u(nx+1,:)=c2t; 
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
    u(1,j+1)=u(2,j)*2*lambda+u(1,j)*(1+k-2*lambda)-4*h*t(j)*(lambda+lambda*h/2);
    for i=2:nx 
        u(i,j+1)=(1+k-2*lambda)*u(i,j)+(lambda-lambda*h/2)*u(i+1,j)+(lambda+lambda*h/2)*u(i-1,j);
    end 
end 
end