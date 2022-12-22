f=@(x) x.^2+2*x-1;
xplot = linspace(-3,3);
yplot = f(xplot);
a=-3;
b=3;
x1=(a+b)/2;
tol=1e-8;
maxiter=100000;

[x_incu,t_incu,iter_incu] = incu(f,a,b,tol,maxiter) ;
[x_budi,t_budi, iter_budi] = budi(f,a,b,tol,maxiter);

syms x
funcion = x^2+2*x+1;
[x_rein,t_rein, iter_rein, cambios_alfa] = rein(funcion,x1,tol, maxiter);
[x_new,t_new, iter_new] = new(funcion,x1,tol,maxiter);


plot(xplot,yplot, ...
    x_incu, f(x_incu), 'r*', ...
     x_budi, f(x_budi), 'g*', ...
     x_rein, f(x_rein), 'b*', ...
      x_new, f(x_new), 'y*')

legend('function','incu', 'budi', 'rein', 'new')

legends = ["incu"; "budi"; "rein" ;"new"];
x_values = [x_incu, x_budi,x_rein,x_new]';
y_values = [f(x_incu), f(x_budi), f(x_rein),f(x_new)]';
time_seconds = [t_incu, t_budi,t_rein,t_new]';
iters = [iter_incu, iter_budi,iter_rein,iter_new]';
table(legends, x_values, y_values, time_seconds, iters)