function [x, iter]=Jacobi(A,b,x0, tol,maxiter)
iter=0; dif=1;
D=diag(diag(A)); U=triu(A,1); L=tril(A,-1);
M_1=diag(1./diag(A));
N=-(U+L);
while dif>tol & iter<=maxiter
    x=M_1*N*x0+M_1*b;
    iter=iter+1;
    dif=norm(x-x0,inf)/norm(x,inf);
    x0=x;
    [iter; x0];
end
end

