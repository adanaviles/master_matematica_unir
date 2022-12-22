n=100:100:1000;
tJ=zeros(1,length(n));
t=zeros(1,length(n));
for i=1:length(n)
    dp=3*ones(1,n(i));
    ds=1*ones(1,n(i)-1);
    A=diag(dp)+diag(ds,1)+diag(ds,-1);
    b=zeros(n(i),1);
    x0=b;
    b(1)=1;
    tic
    [x, iter]=Jacobi(A,b,x0, tol,maxiter);
    TJ(i)=toc
    tic
    x=A\b;
    t(i)=toc
end
plot(n,tJ,'o')
hold on
plot(n,t,'x')
grid on
legend('Jacobi', '\')
hold off