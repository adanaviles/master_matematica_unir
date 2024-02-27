function [nodos, solAprox,t, iter]=disparo_Newton_NoDirich(f,a,b,alfa,beta,N,tol,maxiter)
h=(b-a)/(N+1); x=a:h:b; x=x(:); %el vector x tiene N+2 componentes
iter=1;
incre=tol+1;

t0=0;
[x,Y]=ode45(f,x,[t0,alfa+t0,1,1]');
yb0=Y(end,1); zb0=Y(end,3);
yp0=Y(end,2); zp0=Y(end,4);

while incre>tol && iter<maxiter
    t=t0-(yb0+yp0-beta)/(zb0+zp0); %Meodo de Newton
    [x,Y]=ode45(f,x,[t,alfa+t,1,1]');

    incre=abs(Y(end,1)+Y(end,2)-beta);
    iter=iter+1;
    t0=t; yb0=Y(end,1); zb0=Y(end,3); yp0=Y(end,2); zp0=Y(end,4);
end
if incre<=tol
    nodos=x;
    solAprox=Y;
else
    disp('se necesiitan mas iteraciones')
end
end