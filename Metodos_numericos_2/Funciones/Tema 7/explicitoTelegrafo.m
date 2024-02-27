function [U,x,t]=explicitoTelegrafo(CC1,CC2,CI1,CI2,a,b,Tmax,nx,nt,alpha) 
k=Tmax/nt; h=(b-a)/nx; 
x=a:h:b; 
t=0:k:Tmax; 
U=zeros(nx+1,nt+1); 

U(1,:)=feval(CC1,t); 
U(nx+1,:)=feval(CC2,t); 
U(:,1)=feval(CI1,x);  

for i=2:nx 
    U(i,2)=(1-k^2-k^2/h^2)*U(i,1) +(k^2/(2*h^2))*(U(i+1,1)+U(i-1,1)); 
end 

A=1/k^2+1/(2*k); 
B=2/k^2-2-2/h^2; 
C=1/h^2; 
D=1/(2*k)-1/k^2; 

for j=2:nt 
    for i=2:nx 
        U(i,j+1)=(B/A)*U(i,j) +(C/A)*(U(i+1,j)+U(i-1,j)) +(D/A)*U(i,j-1); 
    end 
end 
end