function [nodos, solAprox,t, iter]=disparo_secanteP1(f,a,b,alfa,beta,N,tol,maxiter)
h=(b-a)/N; r=a:h:b; r=r(:); %el vector x tiene N+2 componentes


t0=1;
[r,U]=ode45(f,r,[alfa,t0]');
ub0=U(N+1,1);
upb0=U(N+1,2);

t1=2;
[r,U]=ode45(f,r,[alfa,t1]');
ub1=U(N+1,1);
upb1=U(N+1,2);

iter=1;
incre=tol+1;

while incre>tol && iter<maxiter
    t=t1-(t1-t0)*(ub1-upb1-beta)/(ub1-upb1-ub0+upb0); %t=t1-(t1-t0)*F(t1)/(F(t1)-F(t0))
    [r,U]=ode45(f,r,[alfa,t]');

    t0=t1; ub0=ub1; upb0=upb1;
    t1=t; ub1=U(N+1,1); upb1=U(N+1,2);
    incre=abs(ub1-upb1-beta);
    iter=iter+1;

end
if incre<=tol
    nodos=r;
    solAprox=U;
else
    disp('se necesiitan mas iteraciones')
end
end