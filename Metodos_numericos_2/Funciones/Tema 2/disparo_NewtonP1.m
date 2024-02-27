function [nodos, solAprox,t, iter]=disparo_NewtonP1(f,a,b,alfa,beta,N,tol,maxiter)
h=(b-a)/(N+1); x=a:h:b; x=x(:); %el vector x tiene N+2 componentes
iter=1;
incre=tol+1;

t0=(beta-alfa)/(b-a);
[x,Y]=ode45(f,x,[t0,alfa-t0,1,-1]');
yb1=Y(end,1); yb2=Y(end,2); zb1=Y(end,3); zb2=Y(end,4);

while incre>tol && iter<maxiter
    t=t0-(yb1+yb2-beta)/(zb1+zb2); %Meodo de Newton
    [x,Y]=ode45(f,x,[t,alfa-t,1,-1]')

    incre=abs(Y(end,1)+Y(end,2)-beta);
    iter=iter+1;
    t0=t; yb1=Y(end,1); yb2=Y(end,2); zb1=Y(end,3); zb2=Y(end,4);
end
if incre<=tol
    nodos=x;
    solAprox=Y;
else
    disp('se necesiitan mas iteraciones')
end
end