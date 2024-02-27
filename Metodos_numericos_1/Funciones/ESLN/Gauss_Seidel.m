function [x, iter]=Gauss_Seidel(A,b,x0, tol,maxiter)
iter=0; dif=1;
D=diag(diag(A)); U=triu(A,1); L=tril(A,-1);
M=(D+L); M_1=inv(M);
N=-U;
x=x0;
while dif>tol & iter<=maxiter
    for j=1:length(b)
        x(j)=(b(j)-U(j,:)*x0-L(j,:)*x)/A(j,j);
    end
    iter=iter+1;
    dif=norm(b-A*x);
    x0=x;
    [iter; x0]
end
end
