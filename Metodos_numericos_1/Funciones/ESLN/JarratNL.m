function [sol ,iter, f_eval, dif , ACOC ] =JarratNL(f,x0 ,tol , maxiter )
digits (200);
% Inicializacion de las variables
iter =1; gamma=2/3;
[fx, dfx]=feval(f,x0);
% Criterio de parada
incre = 1 + tol ;
while incre > tol && iter < maxiter
    % Expresion del metodo de Newton
    y=x0 -gamma*fx/ dfx ;
    [fy, dfy]=feval(f,y);
    x=x0-((3*dfy+dfx)/(3*dfy-dfx))*fx/ dfx/2;
    incre = abs(x-x0);
    I(iter)= incre ;
    % Actualizacion de la estimacion inicial
    dif=(x-x0);
    x0=x;
    [fx , dfx ]= feval(f,x0);
    % Incremento del contador de iteraciones
    iter = iter +1;
end
if length(I) >2
    sol =x*1;
    f_eval=abs(fx);
    dif=abs(dif);
    ACOC = log(I(3 :end)./I(2 :end -1))./ log(I(2 :end -1)./I(1 :end -2));
else
    disp ('necesito mas iteraciones ')
end
end