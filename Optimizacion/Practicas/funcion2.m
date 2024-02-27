
f=@(x) sin(x)+x.^2;
xplot = linspace(-1,1);
yplot = f(xplot);
a=-1;
b=1;
x1=(a+b)/2;
tol=1e-8;
maxiter=100000;

[x_incu,t_incu,iter_incu] = incu(f,a,b,tol,maxiter) ;
[x_budi,t_budi, iter_budi] = budi(f,a,b,tol,maxiter);

syms x
funcion = sin(x)+x^2;
[x_rein,t_rein, iter_rein, cambios_alfa] = rein(funcion,x1,tol, maxiter);
[x_new,t_new, iter_new] = new(funcion,x1,tol,maxiter);


plot(xplot,yplot, ...
    x_incu, f(x_incu), 'r*', ...
     x_budi, f(x_budi), 'g*', ...
     x_rein, f(x_rein), 'b*', ...
      x_new, f(x_new), 'y*')

legend('function','incu', 'budi', 'rein', 'new')

