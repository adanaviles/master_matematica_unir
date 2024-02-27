function [U,x,t] = explicitoOndas_Ejer10(CI1,CI2,a,b,nx,nt,Tmax,alfa) 
% CC1 funcion de t que describe la condicion de contorno en a, 
% CC2 funcion de t que describe la condicion de contorno en b, 
% CI1 funcion de x que describe la condicion inicial en u(x,0), 
% CI2 funcion de x que describe la condicion inicial en u_t(x,0),
h=(b-a)/nx; x=a:h:b; x=x(:); 
k=Tmax/nt; t=0:k:Tmax; 
U=zeros(nx+1,nt+1); 
fx=feval(CI1,x); gx=feval(CI2,x); 
U(:,1)=fx; 

lambda=(k*alfa/h); lambda2=lambda^2;
if lambda<=1 
    disp('se cumple la condicion de convergencia') 
else 
    disp('no se cumple la condicion de convergencia')
end  

U(1,2) = (1-lambda2+k^2/2-pi*h*lambda2)*fx(1) +lambda2/2*(2*fx(2)-2*pi*h*sin(t(1)))+k*gx(1); 
for i=2:nx 
    U(i,2) = (1-lambda2+k^2/2)*fx(i) +lambda2/2*(fx(i+1)+fx(i-1))+k*gx(i); 
end 
U(nx+1,2) = (1-lambda2+k^2/2+h*lambda2)*fx(nx+1) +lambda2/2*(2*fx(nx)+2*pi^2*h*sin(t(1)))+k*gx(nx+1); 

for j=2:nt
    U(1,j+1)=((2+2*pi^2-2*lambda2-k^2-2*pi*h*lambda2)*U(1,j)+2*lambda2*U(2,j)-2*pi*h*lambda2*sin(t(j))-(pi^2+1)*U(1,j-1))/(pi^2+1);
    for i=2:nx 
        U(i,j+1)=((2+2*pi^2-2*lambda2-k^2)*U(i,j)+lambda2*(U(i+1,j)+U(i-1,j))-(pi^2+1)*U(i,j-1))/(pi^2+1); 
    end 
    U(nx+1,j+1)=((2+2*pi^2-2*lambda2-k^2+2*h*lambda2)*U(nx+1,j)+2*lambda2*U(nx,j)+2*pi^2*h*lambda2*sin(t(j))-(pi^2+1)*U(nx+1,j-1))/(pi^2+1);
end 
end