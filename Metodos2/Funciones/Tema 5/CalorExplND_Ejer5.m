function [u,x,t]= CalorExplND_Ejer5(alpha,ci,h1, h2,L,nx,Tmax,nt) 
% Metodo explicito para la ecuacion del calor con condiciones Dirichlet 
% Inicializacion 
h=L/nx;  x=0:h:L; 
k=Tmax/nt;  t=0:k:Tmax; 
cix=feval(ci,x);
c1t=feval(h1,t);
c2t=feval(h2,t); 
u=zeros(nx+1,nt+1); 
u(:,1)=cix';
u(1,:)=c1t;
u(nx+1,:)=c2t; 

% Condicion de estabilidad/convergencia 
lambda=k*alpha^2/h^2; 
if lambda>1/2 
    disp('No se cumple el criterio de convergencia') 
else 
    disp('sin problema') 
end 
for j=1:nt 
    for i=2:nx  
        u(i,j+1)=(k/h^2+k*x(i)'/(2*h))*u(i+1,j) +(-2*k/h^2+k+1)*u(i,j)+(k/h^2-k*x(i)'/(2*h))*u(i-1,j); 
    end 
end 
end