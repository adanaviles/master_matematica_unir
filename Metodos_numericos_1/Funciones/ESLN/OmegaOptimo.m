function []=OmegaOptimo()
%Ejemplo SOR
A=[1 0 0 1; 0 2 0 1; 0 0 3 1;1 1 1 4];
b=[2 3 4 7]'; 
tol=1e-7; maxiter=50; x0=[0 0 0 0]';
w=0.1:0.1:2;
j=1;
while j<=length(w)
    [~, iter(j)]=SOR(w(j),A,b,x0, tol,maxiter);
    j=j+1;
end

plot(w, iter, 'o-')
grid on
xlabel('w')
ylabel('iter')


end