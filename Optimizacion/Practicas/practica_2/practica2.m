tol = 1e-5;
maxiter = 1000;
alpha = 0.01;
iter= 0;
numb_points=50;
x0 = ones(1,numb_points);
[fx,dfx] = fun(x0);

while norm(dfx)>tol && iter<maxiter
    %[alpha, ~, ~] = budi(@(alpha)fun_alpha(alpha,x0,dfx), 0, 0.5, tol, maxiter);
    x0 = x0-alpha*dfx;
    x0(1)=1;
    x0(end)=1;
    [fx,dfx] = fun(x0);
    iter= iter+1;
end


points = linspace(0,1,numb_points);
grid on
plot(points, x0, points,x0, 'o')
ylabel('u(x)') 
title('alfa=0.15, n=30')
norm(fx)