function [u,x,t] = CalorImpl_Ejer6(alpha,ci,h2,L,nx,Tmax,nt) 
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
dp=(1+2*lambda)*ones(nx,1);
dp(1)=dp(1)-2*lambda*h;
ds=-lambda*ones(nx-1,1);
di=ds;
ds(1)=ds(1)*2;
for j=2:nt+1 
    d=u(1:nx,j-1);
    d(end)=d(end)+lambda*u(nx+1,j-1);
    z=Crout(dp,ds,di,d);
    u(1:nx,j)=z;
end 
end