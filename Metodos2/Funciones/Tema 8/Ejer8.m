% (b)
a=1; b=0; n=20; h=(b-a)/n; x=0:-h:b;
dp=-1*ones(n-2,1);
ds=1/4*ones(n-3,1);
di=3/4*ones(n-3,1);
A=diag(dp)+diag(ds,1)+diag(di,-1);
b=zeros(n-2,1);
x0=b;
b(1)=-3/4;
v=Crout(dp,ds,ds,b);
maxiter=400; tol=1e-10;
[xJ, iter]=Jacobi(A,b,x0, tol,maxiter);
[xGS, iter]=Gauss_Seidel(A,b,x0, tol,maxiter);
w=0.2:0.05:2;
for j=1:length(w)
    [x, iter(j)]=SOR(w(j),A,b,x0, tol,maxiter);
end
%plot(w,iter)
[xS, iter]=SOR(1.35,A,b,x0, tol,maxiter);
for k=1:20
    X(k)=1-(3^(k)-1)./(3^20-1);
end
plot(v,'o')
hold on
plot([1;xJ;0],'x')
plot([1;xGS;0],'+')
plot([1;xS;0],'sq')
plot(X,'sq')
grid on
legend('Directo','Jacobi','Gauss-Seidel','SOR','Exacta')
hold off