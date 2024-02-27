function [U,x,t]=implicitoOndas_Ejer6(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alfa) 
% CC1 funcion de t que describe la condicion de contorno en a, 
% CC2 funcion de t que describe la condicion de contorno en b,
% CI1 funcion de x que describe la condicion inicial en u(x,0), 
% CI2 funcion de x que describe la condicion inicial en u_t(x,0), 
h=(b-a)/nx; k=Tmax/nt; 
x=a:h:b; x=x(:); 
t=0:k:Tmax; 
U=zeros(nx+1,nt+1);

fx=feval(CI1,x); gx=feval(CI2,x); 
U(:,1)=fx; 
U(1,:)=feval(CC1,t); 
U(nx+1,:)=feval(CC2,t);

lambda=k*alfa/h; lambda2=lambda^2;

for i=2:nx 
    U(i,2) = (1-lambda2-k^2*x(i)/2)*fx(i) +lambda2/2*(fx(i+1)+fx(i-1))+k*gx(i)-k^2*t(1); 
end 

dpa=(1+lambda2)*ones(nx-1,1); 
dsa=-lambda2/2*ones(nx-2,1); 
dia=dsa; 

dpb=-dpa; 
dsb=-dsa; 
dib=dsb; 
B=diag(dpb)+diag(dsb,1)+diag(dib,-1);

for j=2:nt 
    d=(2-k^2*x(2:nx)).*U(2:nx,j)+B*U(2:nx,j-1)-2*k^2*t(j);
    d(end)=d(end)+lambda2/2*(t(j+1)^2+t(j-1)^2);
    z=Crout(dpa,dsa,dia,d); 
    U(2:nx,j+1)=z; 
end 
end