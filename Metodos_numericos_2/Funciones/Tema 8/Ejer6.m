% (b)
a=0; b=2; n=9; h=(b-a)/n; x=0:h:b;
dp=-(2+h^2)*ones(n,1);
dp(1)=dp(1)+1;
ds=1*ones(n-1,1);
A=diag(dp)+diag(ds,1)+diag(ds,-1);
b=zeros(n,1);
x0=b;
b(end)=-1;
v=[A\b; 1];
SolExacta= @(x) 0.133.*exp(x)+0.133.*exp(-x);
u=SolExacta(x);

% (c)
maxiter=400; tol=1e-10;
[xJ, iter]=Jacobi(A,b,x0, tol,maxiter);
[xGS, iter]=Gauss_Seidel(A,b,x0, tol,maxiter);
[xS, iter]=SOR(1.6,A,b,x0, tol,maxiter);

plot(x,v,'o')
hold on
plot(x,[xJ;1],'x')
plot(x,[xGS;1],'+')
plot(x,[xS;1],'sq')
plot(x,u)
grid on
legend('Directo','Jacobi','Gauss-Seidel','SOR','Exacta')
hold off