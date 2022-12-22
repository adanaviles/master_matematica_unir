function [U,x,t] = explicitoOndas_Ejer5(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alfa) 
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
U(nx+1,:)=feval(CC2,t); 

lambda=(k*alfa/h); lambda2=lambda^2;
if lambda<=1 
    disp('se cumple la condicion de convergencia') 
else 
    disp('no se cumple la condicion de convergencia')
end  

for i=2:nx 
    U(i,2) = (1-lambda2)*fx(i) +lambda2/2*(fx(i+1)+fx(i-1))+k*gx(i)+k*lambda/2*(fx(i+1)-fx(i-1))-k^2/2*cos(pi*x(i)); 
end 
for j=2:nt 
    for i=2:nx 
        U(i,j+1)=((6-2*lambda2)*U(i,j)+lambda2*(U(i+1,j)+U(i-1,j))-3*U(i,j-1)+k*lambda*(U(i+1,j)-U(i-1,j))-k^2*cos(pi*x(i)))/3; 
    end 
end 
end