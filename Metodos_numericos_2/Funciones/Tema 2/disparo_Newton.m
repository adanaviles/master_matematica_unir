function [nodos, solAprox,t, iter]=disparo_Newton(f,a,b,alfa,beta,N,tol,maxiter)
h=(b-a)/(N+1); x=a:h:b; x=x(:); %el vector x tiene N+2 componentes
iter=1;
incre=tol+1;

t0=0;
[x,Y]=ode45(f,x,[alfa,t0,0,1]');
yb0=Y(end,1); zb0=Y(end,3);

while incre>tol && iter<maxiter
    t=t0-(yb0-beta)/(zb0); %Meodo de Newton
    [x,Y]=ode45(f,x,[alfa,t,0,1]');

    incre=abs(Y(end,1)-beta);
    iter=iter+1;
    t0=t; yb0=Y(end,1); zb0=Y(end,3);
end
if incre<=tol
    nodos=x;
    solAprox=Y;
else
    disp('se necesiitan mas iteraciones')
end
end