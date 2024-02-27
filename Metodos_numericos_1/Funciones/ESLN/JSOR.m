function [x, iter]=JSOR(w,A,b,x0, tol,maxiter)
iter=0; dif=1;
M_1=diag(1./diag(A));
while dif>tol & iter<=maxiter
    x=x0+w*M_1*(b-A*x0);
    iter=iter+1;
    dif=norm(b-A*x);
    x0=x;
    [iter; x0]
end
end