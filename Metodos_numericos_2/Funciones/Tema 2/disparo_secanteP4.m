function [nodos, solAprox,t, iter]=disparo_secanteP4(f,a,b,alfa,beta,N,tol,maxiter)
h=(b-a)/(N); x=a:h:b; x=x(:); %el vector x tiene N+2 componentes


t0=beta;
[x,Y]=ode45(f,x,[t0,alfa-t0]');
yb00=Y(1 ,1); ypb00=Y(1,2);
yb01=Y(end ,1);ypb01=Y(end,2);

t1=(beta-alfa)/(b-a);
[x,Y]=ode45(f,x,[t1,alfa-t1]');
yb10=Y(1 ,1); ypb10=Y(1,2);
yb11=Y(end ,1);ypb11=Y(end,2);

iter=1;
incre=tol+1;

while incre>tol && iter<maxiter
    t=t1-(t1-t0)*(2*yb10+yb11+ypb10+ypb11-beta)/(2*yb10+yb11+ypb10+ypb11-(2*yb00+yb01+ypb00+ypb01)); %t=t1-(t1-t0)*F(t1)/(F(t1)-F(t0))
    [x,Y]=ode45(f,x,[t,alfa-t]');

    t0=t1; yb00=yb10; ypb00=ypb10; yb01=yb11;ypb01=ypb11;
    t1=t;  yb10=Y(1 ,1); ypb10=Y(1,2); yb11=Y(end ,1);ypb11=Y(end,2);
    incre=abs(2*yb10+yb11+ypb10+ypb11-beta);
    iter=iter+1;

end
if incre<=tol
    nodos=x;
    solAprox=Y;
else
    disp('se necesiitan mas iteraciones')
end
end