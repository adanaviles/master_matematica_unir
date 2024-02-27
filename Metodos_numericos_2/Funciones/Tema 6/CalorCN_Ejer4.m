function [u,x,t] = CalorCN_Ejer4(alpha,ci,h1,h2,L,nx,Tmax,nt) 
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
% if lambda>1/2 
%     disp('No se cumple el criterio de convergencia') 
% else 
%     disp('sin problema') 
% end
dp=(1+lambda)*ones(nx-1,1);
ds=-lambda/2*ones(nx-2,1);
di=ds;
dpB=(1-lambda)*ones(nx-1,1);
dsB=lambda/2*ones(nx-2,1);
diB=dsB;
B=diag(dpB,0)+diag(dsB,1)+diag(diB,-1);
for j=2:nt+1 
    d=B*u(2:nx,j-1)+2*k*ones(nx-1,1);
    d(1)=d(1)+lambda/2*(u(1,j)+u(1,j-1));
    d(end)=d(end)+lambda/2*(u(nx+1,j)+u(nx+1,j-1));
    z=Crout(dp,ds,di,d);
    u(2:nx,j)=z;
end 
end