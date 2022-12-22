function [nodos, solAprox,t, iter]=disparo_NewtonP7(f,a,b,alfa,beta, gamma,N,tol,maxiter)
h=(b-a)/(N); x=a:h:b; x=x(:); %el vector x tiene N+2 componentes
iter=1;
incre=tol+1;

t0=1;
[x,Y]=ode45(f,x,[alfa,t0,gamma-t0,0,1,-1]');
yb1=Y(end,3);zb1=Y(end,6);

while incre>tol && iter<maxiter
    t=t0-(yb1-beta)/(zb1); %Meodo de Newton
    [x,Y]=ode45(f,x,[alfa,t,gamma-t,0,1,-1]');

    incre=abs(Y(end,3)-beta);
    iter=iter+1;
    t0=t; yb1=Y(end,3); zb1=Y(end,6);
end
if incre<=tol
    nodos=x;
    solAprox=Y;
else
    disp('se necesiitan mas iteraciones')
end
end