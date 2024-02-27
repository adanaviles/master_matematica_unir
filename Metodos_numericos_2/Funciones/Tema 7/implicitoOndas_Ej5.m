function [U,x,t] = implicitoOndas_Ej5(CC1,CI1,CI2,a,b,nx,nt,Tmax,alfa) 
% CC1 funcion de t que describe la condicion de contorno en a, 
% CC2 funcion de t que describe la condicion de contorno en b, 
% CI1 funcion de x que describe la condicion inicial en u(x,0), 
% CI2 funcion de x que describe la condicion inicial en u_t(x,0),
h=(b-a)/nx; x=a:h:b; x=x(:); 
k=Tmax/nt; t=0:k:Tmax; 
U=zeros(nx+1,nt+1); 
fx=feval(CI1,x); gx=feval(CI2,x); 
U(:,1)=fx; 
U(1,:)=feval(CC1,t);  

lambda=(k*alfa/h); lambda2=lambda^2;

for i=2:nx 
    U(i,2)=(1-lambda2)*fx(i)+lambda2/2*(fx(i+1)+fx(i-1))+k*gx(i)+(k^2/2)*exp(-t(1));
    U(nx+1,2)=(1-lambda2)*fx(nx+1)+ lambda2*fx(nx)-lambda2/2*6*h*cos(t(1)) +k*gx(nx+1)+(k^2/2)*exp(-t(1));
end 

dpa=(1+lambda2)*ones(nx,1); 
dsa=-lambda2/2*ones(nx-1,1); 
dia=dsa; 
dia(end)=-lambda2;

dpb=-(1+lambda2)*ones(nx,1); ; 
dsb=lambda2/2*ones(nx-1,1); 
dib=dsb; 
dib(end)=lambda2;
B=diag(dpb)+diag(dsb,1)+diag(dib,-1);

for j=2:nt 
    d=2*U(2:nx+1,j)+B*U(2:nx+1,j-1)+k^2*exp(-t(j))*ones(length(x(2:nx+1)),1); 
    d(1)=d(1)+lambda2/2*(exp(-t(j+1))+exp(-t(j-1)));
    d(end)=d(end)-3*h*lambda2*(cos(t(j+1))+cos(t(j-1)));
    z=Crout(dpa,dsa,dia,d); 
    U(2:nx+1,j+1)=z; 
end 
end