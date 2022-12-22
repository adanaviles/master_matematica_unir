function [nodos, solAprox,t, iter]=disparo_secante(f,a,b,alfa,beta,N,tol,maxiter)
h=(b-a)/(N+1); x=a:h:b; x=x(:); %el vector x tiene N+2 componentes
iter=1;
incre=tol+1;

t0=0;
[x,Y]=ode45(f,x,[alfa,t0]');
yb0=Y(end,1);

t1=(beta-alfa)/(b-a);
[x,Y]=ode45(f,x,[alfa,t1]');
yb1=Y(end,1);

while incre>tol && iter<maxiter
    t=t1-(t1-t0)*(yb1-beta)/(yb1-yb0); %t=t1-(t1-t0)*F(t1)/(F(t1)-F(t0))
    [x,Y]=ode45(f,x,[alfa,t]');

    incre=abs(Y(end,1)-beta);
    iter=iter+1;
    t0=t1; yb0=yb1;
    t1=t; yb1=Y(end,1);
end
if incre<=tol
    nodos=x;
    solAprox=Y;
else
    disp('se necesiitan mas iteraciones')
end
end