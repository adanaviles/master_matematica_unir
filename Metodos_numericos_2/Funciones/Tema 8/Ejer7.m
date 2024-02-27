b=1:1:50;
x0=zeros(50,1);
for i=1:50
    for j=1:50
        if i<=j
            A(i,j)=i*(50-j+1);
        else
            A(i,j)=A(j,i);
        end
    end
end
x=A\b';
maxiter=400; tol=1e-10;
[xJ, iter]=Jacobi(A,b',x0, tol,maxiter);
[xGS, iter]=Gauss_Seidel(A,b',x0, tol,maxiter);
[xS, iter]=SOR(1.6,A,b',x0, tol,maxiter);
subplot(2,2,1);
plot(x)
legend('Driecto')
subplot(2,2,2);
plot(xJ)
legend('Jacobi')
subplot(2,2,3);
plot(xGS)
legend('Gauss-Seidel')
subplot(2,2,4);
plot(xS)
legend('SOR')