function [nodos, solAprox,t, iter]=disparo_NewtonP5(f,a,b,alfa,beta, gamma,N,tol,maxiter)
h=(b-a)/(N+1); x=a:h:b; x=x(:); %el vector x tiene N+2 componentes
iter=1;
incre=tol+1;

t0=(beta-alfa)/(b-a);
[x,Y]=ode45(f,x,[alfa,gamma,t0,0,0,1]');
yb1=Y(end,1);zb1=Y(end,4);

while incre>tol && iter<maxiter
    t=t0-(yb1-beta)/(zb1); %Meodo de Newton
    [x,Y]=ode45(f,x,[alfa,gamma,t,0,0,1]');

    incre=abs(Y(end,1)-beta);
    iter=iter+1;
    t0=t; yb1=Y(end,1); zb1=Y(end,4);
end
if incre<=tol
    nodos=x;
    solAprox=Y;
else
    disp('se necesiitan mas iteraciones')
end
end