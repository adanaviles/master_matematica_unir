a=1; b=5; n=8; h=(b-a)/n; x=a:h:b
dp=1*ones(n-1,1);
ds=-1*ones(n-2,1);
di=1/3*ones(n-2,1);
A=diag(dp)+diag(ds,1)+diag(di,-1);
b=zeros(n-1,1);
x0=b;
b(1)=-10000/3;
b(end)=50000;

maxiter=400; tol=1e-5;
[xJ, iter]=Jacobi(A,b,x0, tol,maxiter);
[xGS, iter]=Gauss_Seidel(A,b,x0, tol,maxiter)