function [U,incre,iter,x,y]=ElipticaGaussSeidel_Ejem6(f0,f1,a,b,c,d,nx,ny,funcionti,maxiter,tol) 
%Metodo Gauss-Seidel para aproximar la solucion del problema eliptico 
h=(b-a)/nx; x=a:h:b; 
k=(d-c)/ny; y=c:k:d; 
f0x=feval(f0,x);
f1x=feval(f1,x);
g0y=f0x(1):-k/2:f1x(1);
g1y=g0y; 
u0=(sum(f0x+f1x)/(nx+1)+sum(g0y+g1y)/(ny+1))/4; 
U=u0*ones(ny+1,nx+1); 

U(1,:)=g0y; 
U(ny+1,:)=g1y; 
U(:,1)=f0x(:); 
U(:,nx+1)=f1x(:);

iter=1; 
incre=tol+1; 
lambda=h/k; lambda2=lambda^2;
beta=2*(1+lambda2); beta2=beta-2*h*lambda2;

while iter<maxiter && incre>tol 
    for i=2:nx 
        for j=2:ny 
            U(1,j)=(2*lambda2*U(2,j)+ U(1,j-1)+U(1,j+1))/(beta-h*lambda2);
            v=(lambda2*(U(i-1,j)+U(i+1,j)) +U(i,j-1)+U(i,j+1))/beta; 
            U(nx+1,j)=(2*lambda2*U(nx,j)+ U(nx+1,j-1)+U(nx+1,j+1))/beta2; 
            incr=max(abs(U(i,j)-v)); 
            U(i,j)=v; 
        end 
    end  
    iter=iter+1; 
end 
end