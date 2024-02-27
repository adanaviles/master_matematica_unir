function [U,x,t]=implicitoTelegrafo(CC1,CC2,CI1,CI2,a,b,Tmax,nx,nt) 
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

dpa=(1/k^2+1/(2*k)+1/h^2)*ones(nx-1,1); 
dsa=(-1/(2*h^2))*ones(nx-2,1); 
dia=dsa; 

dpb=(-1/k^2+1/(2*k)-1/h^2)*ones(nx-1,1);
dsb=-dsa; 
dib=dsb; 
B=diag(dpb)+diag(dsb,1)+diag(dib,-1);

for j=2:nt 
    d=(2/k^2-2)*U(2:nx,j)+B*U(2:nx,j-1); 
    z=Crout(dpa,dsa,dia,d); 
    U(2:nx,j+1)=z; 
end 
end