a=1;
b=4;
x1=(a+b)/2;
tol=1e-4;
maxiter=100000;

[x_incu,t_incu,iter_incu] = incu('funcionrr',a,b,tol,maxiter) ;
[x_budi,t_budi, iter_budi] = budi('funcionrr',a,b,tol,maxiter);

legends = ["incu"; "budi"]
x_values = [x_incu, x_budi,]';
y_values = [funcionrr(x_incu), funcionrr(x_budi)]';
time_seconds = [t_incu, t_budi]';
iters = [iter_incu, iter_budi]';
table(legends, x_values, y_values)

