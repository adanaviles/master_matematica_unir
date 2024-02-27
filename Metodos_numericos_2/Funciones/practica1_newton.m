
[nodos, solaprox, t, iter] = DisparoNewtonPractica('ejercicio_practica_newton', 0, pi, 1, 2, 10, 1e-8, 100)
function dy = ejercicio_practica_newton(x,y)
    dy=[y(2);
    x.*y(1)*y(2)-x.*cos(x)*y(1)-sin(x);
    y(4);
    x.*y(2)*y(3)-x.*cos(x)*y(3)+x.*y(1)*y(4);
    ];
end

function [nodos, solaprox, t, iter] =DisparoNewtonPractica(f, a,b ,alfa, beta ,n , tol, maxiter)
h=(b-a)/(n) ; x=a:h:b; x=x(:); %el vector x tiene n+2 componentes
t0 = 0; %tomo t inicial
[x, Y] = ode45(f, x, [t0, alfa-t0, 1, -1]'); %calculo y(x) para el pvi pedido
yb1 = Y(end, 1); yb2 = Y(end, 2);
zb1 = Y(end, 3); zb2 = Y(end, 4);
iter = 1;
incre = tol +1;
while incre > tol && iter <maxiter
t = t0-(yb1-2*yb2-beta)/(zb1-2*zb2);
[x, Y] = ode45(f, x, [t, alfa-t, 1, -1]');
t0 = t;
yb1 = Y(end, 1); yb2 = Y(end, 2);
zb1 = Y(end, 3); zb2 = Y(end, 4);
%una vez he actualizado los valores, calculo incre
incre = abs(yb1-2*yb2-beta);
iter= iter+1;
end
if incre <= tol
nodos=x;
solaprox=Y;
else
disp('se necesitan mas iteraciones')
end
end