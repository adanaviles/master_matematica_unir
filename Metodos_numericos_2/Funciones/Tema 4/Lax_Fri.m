function [U,x,t]=Lax_Fri(cc1,cc2,ci,a,L,nx,Tmax,nt) 
%MetododeLax-Friedrichs 
 
h=L/nx;     x=0:h:L; 
k=Tmax/nt;  t=0:k:Tmax; 
c1t=feval(cc1,t);
c2t=feval(cc2,t); 
cix=feval(ci,x); 

U=zeros(nx+1,nt+1); 
U(1,:)=c1t;
U(nx+1,:)=c2t;
U(:,1)=cix'; 
U(1,1)=(c1t(1)+cix(1))/2; 
U(end,1)=(c2t(1)+cix(end))/2; 
lambda=k*a/h; 
if lambda>1 
    disp('No se cumple la condicion de estabilidad') 
else 
    disp('sin problema') 
end 
for j=1:nt 
    for i=2:nx 
        U(i,j+1)=(1/2)*(U(i+1,j)+U(i-1,j))-lambda/2*(U(i+1,j)-U(i-1,j)); 
    end 
end 
end