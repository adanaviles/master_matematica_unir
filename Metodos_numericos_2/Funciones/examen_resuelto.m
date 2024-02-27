
a=1; b=2; alfa=3/2; beta=9/2;
n=19; maxiter=50;
tol=1e-5;

funcion=@(x,y)[y(2);-y(1).*y(2)+2*y(1).*x+2];

[nodos, solAprox,t, iter]=disparo_secante(funcion,a,b,alfa,beta,n,tol,maxiter);

function dy=ejemplo10(x,y)
    dy=[y(2); -y(1).*y(2)+2+2*x.*y(1)];
end


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
