function [nodos, solAprox,t, iter]=disparo_secante_NoDirich_monse(f,a,b,alfa,beta,N,tol,maxiter)
h=(b-a)/(N+1); x=a:h:b; x=x(:); %el vector x tiene N+2 componentes
iter=1;
incre=tol+1;

t0=0;
[x,Y]=ode45(f,x,[t0,(alfa-t0)/2]');
yb0=Y(end,1);
yp0=Y(end,2);

t1=(beta-alfa)/(b-a);
[x,Y]=ode45(f,x,[t1,(alfa-t1)/2]');
yb1=Y(end,1);
yp1=Y(end,2);

while incre>tol && iter<maxiter
    t=t1-(t1-t0)*(yb1-2*yp1-beta)/(yb1-2*yp1-yb0+2*yp0); %t=t1-(t1-t0)*F(t1)/(F(t1)-F(t0))
    [x,Y]=ode45(f,x,[t,(alfa-t)/2]');

    incre=abs(Y(end,1)-2*Y(end,2)-beta);
    iter=iter+1;
    t0=t1; yb0=yb1; yp0=yp1;
    t1=t; yb1=Y(end,1); yp1=Y(end,2);
end
if incre<=tol
    nodos=x;
    solAprox=Y;
else
    disp('se necesiitan mas iteraciones')
end
end