function [u,x,t] = CalorCN_Ejem3(alpha,ci,L,nx,Tmax,nt) 
% Metodo explicito para la ecuacion del calor con condiciones Dirichlet 
% Inicializacion 
h=L/nx; x=0:h:L;
k=Tmax/nt; t=0:k:Tmax; 
cix=feval(ci,x); cix(:);
u=zeros(nx+1,nt+1);
u(:,1)=cix; 

lambda=k*alpha^2/h^2; 

dp=[(1+lambda)*ones(1,nx) 1+lambda+lambda*h];
ds=[-lambda -lambda/2*ones(1,nx-1)];
di=[-lambda/2*ones(1,nx-1) -lambda];

dpB=[(1-lambda)*ones(1,nx) 1-lambda-lambda*h];
dsB=[lambda lambda/2*ones(1,nx-1)];
diB=[lambda/2*ones(1,nx-1) lambda];
B=diag(dpB,0)+diag(dsB,1)+diag(diB,-1);

d=zeros(nx+1,1);
for j=1:nt
    d=k/2*(exp(-t(j))+exp(-t(j+1)))*ones(nx+1,1);
    d=B*u(:,j)+d;
    u(:,j+1)=Crout(dp,ds,di,d)';
end 
end