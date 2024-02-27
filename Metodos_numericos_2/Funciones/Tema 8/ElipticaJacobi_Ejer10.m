function [U,incre,iter,x,y]=ElipticaJacobi_Ejer10(f0,f1,a,b,c,d,nx,ny,funcionti,maxiter,tol) 
%Metodo Gauss-Seidel para aproximar la solucion del problema eliptico 
h=(b-a)/nx; x=a:h:b; 
k=(d-c)/ny; y=c:k:d; 
f0x=feval(f0,x);
f1x=feval(f1,x);
g0y=f0x(1):k/2:f1x(1);
g1y=g0y; 
u0=(sum(f0x+f1x)/(nx+1)+sum(g0y+g1y)/(ny+1))/4; 
U=u0*ones(ny+1,nx+1); 

U(:,1)= g0y(:);
U(:,nx+1)=g1y(:);
U(1,:)=f0x;
U(ny+1,:)=f1x;

iter=1; 
incre=tol+1; 
lambda=h/k; lambda2=lambda^2;

while iter<maxiter && incre>tol 
    for i=2:ny 
        for j=2:nx 
            U(i,1)=(-4*lambda2*x(1)^2*(U(i+1,1)+U(i-1,1))+2*U(i,2)+2*h^2*feval(funcionti,y(i),x(1)))/(2*(1-4*lambda2*x(1)^2));
            U(i,j)=(-4*lambda2*x(j)^2*(U(i+1,j)+U(i-1,j))+U(i,j+1)+U(i,j-1)+2*h^2*feval(funcionti,y(i),x(j)))/(2*(1-4*lambda2*x(j)^2)); 
            U(i,nx+1)=(-4*lambda2*x(nx+1)^2*(U(i+1,nx+1)+U(i-1,nx+1))+2*U(i,nx)+2*h^2*feval(funcionti,y(i),x(nx+1)))/(2*(1-4*lambda2*x(nx+1)^2)); 
        end 
    end  
    incre=max(max(abs(U))); 
    iter=iter+1;
end 
end