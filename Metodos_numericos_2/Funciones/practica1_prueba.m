
[x, Y, t, iter, incre] = DisparoSecantePractica('ejercicio_practica', 0, pi, 1, 2, 10, 1e-8, 100)

function dy = ejercicio_practica(x,y)
    dy=[y(2) ; x*y(1)*y(2)-x.*cos(x)*y(1)-sin(x)];
end

function [x, Y, t, iter, incre] = DisparoSecantePractica(f, a, b, alfa,beta ,n , tol, maxiter)
    h=(b-a)/(n) ; x=a:h:b; x=x(:); %el vector x tiene n+2 componentes
    t0 = 0; %tomo t inicial
    [x, Y] = ode45(f, x, [t0, alfa-t0]'); %calculo y(x) para el pvi pedido
    ub0 = Y(end, 1) ; %tomo el ultimo valor, y(t0)
    upb0 = Y(end, 2); %tomo la derivada
    t1 = 1;
    [x, Y]= ode45(f, x, [t1 ,alfa-t1]');
    ub1 = Y(end, 1) ; %tomo el ultimo valor, y(t0)
    upb1 = Y(end, 2); %tomo la derivada
    iter = 2;
    incre = abs(ub1-2*upb1-beta);
    while incre > tol && iter <maxiter
    t = t1-((t1-t0)*(ub1-2*upb1-beta))./(ub1-2*upb1-ub0+2*upb0);
    [x, Y]= ode45(f, x, [t ,alfa-t]');
    t0 = t1; t1 = t;
    ub0 = ub1; upb0 = upb1;
    ub1 = Y(end, 1); upb1 = Y(end, 2) ;
    incre = abs(ub1-2*upb1-beta); %necesitoque el esto sea menor a la tolerancia
    iter= iter+1;
    end
    if incre > tol
    disp('se necesitan mas iteraciones')
    end
end