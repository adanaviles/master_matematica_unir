function [nodos, solAprox,t,q, iter]=disparo_secanteP6(f,a,b,alfa,beta,N,tol,maxiter)
h=(b-a)/(N); x=a:h:b; x=x(:); %el vector x tiene N+2 componentes


t0=beta;
q0=beta;
[x,Y]=ode45(f, x ,[alfa,t0,alfa,q0]');
wL=Y(end ,1); 
ddwL=Y(end ,3);

t1=1;
q1=1;
[x,Y]=ode45(f,x ,[alfa,t1,alfa,q1]');
wL1=Y(end ,1);
ddwL1=Y(end ,3);

iter=1;
incre=tol+1;
incre2=tol+1;

while incre>tol && incre2>tol && iter<maxiter
    t=t1 -((t1 -t0)*(wL1-beta))./(wL1-wL); 
    q=q1 -((q1 -q0)*(ddwL1-beta))./(ddwL1-ddwL);
    [x,Y]=ode45(f,x,[alfa,t,alfa,q]');

    t0=t1; q0=q1; wL=wL1; ddwL=ddwL1;
    t1=t; q1=q;  wL1=Y(end ,1); ddwL1=Y(end ,3);
    incre=abs(wL1-beta);
    incre2=abs(ddwL1-beta);
    iter=iter+1;

end
if incre<=tol || incre2<tol
    nodos=x;
    solAprox=Y;
else
    disp('se necesiitan mas iteraciones')
end
end