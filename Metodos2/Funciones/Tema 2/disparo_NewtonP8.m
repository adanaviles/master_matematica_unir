function [nodos, solAprox,t, iter]=disparo_NewtonP8(f,a,b,alfa,beta, gamma,N,tol,maxiter)
h=(b-a)/(N); x=a:h:b; x=x(:); %el vector x tiene N+2 componentes
iter=1;
incre=tol+1;

t0=(beta-alfa)/(b-a);
[x,Y]=ode45(f,x,[alfa,t0,gamma,0,1,0]');
dy0=Y(1,2); dy1=Y(end,2);
dz0=Y(1,5); dz1=Y(end,5);

while incre>tol && iter<maxiter
    t=t0-(dy0+dy1-beta)/(dz0+dz1) %Meodo de Newton
    [x,Y]=ode45(f,x,[alfa,t,gamma,0,1,0]');

    incre=abs(Y(1,2)+Y(end,2)-beta);
    iter=iter+1;
    t0=t; dy0=Y(1,2); dy1=Y(end,2);dz0=Y(1,5); dz1=Y(end,5);
end
if incre<=tol
    nodos=x;
    solAprox=Y;
else
    disp('se necesiitan mas iteraciones')
end
end