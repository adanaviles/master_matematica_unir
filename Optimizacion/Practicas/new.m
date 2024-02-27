function [x,t,iter] = new(f,x0,tol,maxiter)
tic
x(1) = x0;
n1 = tol+1;
h = tol+1;
iter = 0;
while (abs(n1) > tol && abs(h) > tol) && iter < maxiter
    n1 = eval(subs(diff(f),(x(iter+1))));
    ddf = eval(subs(diff(f,2),(x(iter+1))));
    h = n1/ddf;
    x(iter+2) = x(iter+1)-h;
    iter = iter+1;
end
x = x(end);
t = toc;
end