
N=11;
a=0; b=pi; alfa=1;beta=2;
tol=1e-8; maxiter=100;

[nodos, solAprox,t, iter]=disparo_secanteP2('ejercicio_2_secante',a,b,alfa,beta,N,tol,maxiter)

function dx=ejercicio_2_secante(x,y)
dx=[y(2);...
    x.*y(1).*y(2)-x.*cos(x).*y(1)-sin(x)];
end

function [nodos, solAprox,t, iter]=disparo_secanteP2(f,a,b,alfa,beta,N,tol,maxiter)
    h=(b-a)/(N-1);
    x=a:h:b;
    x=x(:);
    iter=1;
    incre=tol+1;
    % aqui defino el t0 y t1
    t0=0;
    t1=(beta-alfa)/(b-a);
    [x,Y]=ode45(f,x,[t0,alfa-t0]');
    [x,Y]=ode45(f,x,[t1,alfa-t1]');
    yb0=Y(end,1);
    yb1=Y(end,2);
    zb0=Y(end,1); zb1=Y(end,2);
    
    while incre>tol && iter<maxiter
        t=t1-(t1-t0)*(zb0-2*zb1-beta)/(zb0-2*zb1-yb0+2*yb1); %t=t1-(t1-t0)*F(t1)/(F(t1)-F(t0))
        [x,Y]=ode45(f,x,[t,alfa-t]'); % adaptado a mi problema inicial
    
        incre=abs(Y(end,1)-2*Y(end,2)-beta);
        iter=iter+1;
        t0=t1; yb0=zb0; yb1=zb1;
        t1=t; zb0=Y(end,1); zb1=Y(end,2);
    end
    if incre<=tol
        nodos=x;
        solAprox=Y;
    else
        disp('se necesitan mas iteraciones')
    end
end
