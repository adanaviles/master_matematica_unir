function [U,incre,iter,x,y]=ElipticaJacobi(f0,f1,g0,g1,a,b,c,d,nx,ny,funcionti,maxiter,tol) 
%Metodo Gauss-Seidel para aproximar la solucion del problema eliptico 
h=(b-a)/nx; x=a:h:b; 
k=(d-c)/ny; y=c:k:d; 
f0x=feval(f0,x); f1x=feval(f1,x); 
g0y=feval(g0,y); g1y=feval(g1,y); 
u0=(sum(f0x+f1x)/(nx+1)+sum(g0y+g1y)/(ny+1))/4; 
U=u0*ones(ny+1,nx+1); 

U(1,:)=feval(f0,x); 
U(ny+1,:)=feval(f1,x); 
U(:,1)=feval(g0,y); 
U(:,nx+1)=feval(g1,y);

iter=1; 
incre=tol+1; 
lambda=h/k; 
p=1/(2*(lambda^2+1)); 
q=lambda^2*p; 
r=-h^2*p; 
V=U; 
while iter<maxiter && incre>tol 
    for j=2:nx 
        for i=2:ny 
            V(i,j)=q*(U(i+1,j)+U(i-1,j))+ p*(U(i,j+1)+U(i,j-1))+ r*feval(funcionti,x(j),y(i)); 
        end 
    end 
    incre=max(max(abs(U-V))); 
    U=V; 
    iter=iter+1; 
end 
end