function [u,x,t] = CalorImpl_Ej2(alpha,ci,h2,L,nx,Tmax,nt) 
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
% if lambda>1/2 
%     disp('No se cumple el criterio de convergencia') 
% else 
%     disp('sin problema') 
% end

for j=2:nt+1 
    dp=(1+2*lambda-k*t(j)^2)*ones(nx,1);
    ds= [-2*lambda -lambda*ones(1,nx-2)];
    di=-lambda*ones(1,nx-1);
    d=u(1:nx,j-1)+(k*x(1:nx).*cos(x(1:nx)*t(j)))';
    d(1)=d(1)-2*lambda*h*t(j);
    d(end)=d(end)+lambda*sin(t(j));
    z=Crout(dp,ds,di,d);
    u(1:nx,j)=z;
end 
end