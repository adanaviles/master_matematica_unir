function [U,x,t]=implicitoOndas_Ejer10(CI1,CI2,a,b,nx,nt,Tmax,alfa) 
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

lambda=k*alfa/h; lambda2=lambda^2;

U(1,2) = (1-lambda2+k^2/2-pi*h*lambda2)*fx(1) +lambda2/2*(2*fx(2)-2*pi*h*sin(t(1)))+k*gx(1); 
for i=2:nx 
    U(i,2) = (1-lambda2+k^2/2)*fx(i) +lambda2/2*(fx(i+1)+fx(i-1))+k*gx(i); 
end 
U(nx+1,2) = (1-lambda2+k^2/2+h*lambda2)*fx(nx+1) +lambda2/2*(2*fx(nx)+2*pi^2*h*sin(t(1)))+k*gx(nx+1); 


dpa=(1+pi^2+lambda2)*ones(nx+1,1); 
dpa(1)=dpa(1)+pi*h*lambda2; dpa(end)=dpa(end)-h*lambda2;
dsa=-lambda2/2*ones(nx,1); 
dsa(1)=dsa(1)*2;
dia=-lambda2/2*ones(nx,1);
dia(end)=dia(end)*2;

dpb=-dpa; 
dsb=-dsa; 
dib=-dia; 
B=diag(dpb)+diag(dsb,1)+diag(dib,-1);

for j=2:nt 
    d=(2+2*pi^2-k^2)*U(:,j)+B*U(:,j-1);
    d(1)=d(1)-pi*h*lambda2*(sin(t(j+1))+sin(t(j-1)));
    d(end)=d(end)+pi^2*h*lambda2*(sin(t(j+1))+sin(t(j-1)));
    z=Crout(dpa,dsa,dia,d); 
    U(:,j+1)=z; 
end 
end