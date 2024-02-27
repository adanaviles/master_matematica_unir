function [sol ,iter, f_eval, dif , ACOC ] =SecanteNL(f,x0, x1 ,tol , maxiter )
digits (200);
% Inicializacion de las variables
iter =1;
[fx, dfx]=feval(f,x0);
[fx1, dfx1]=feval(f,x1);
% Criterio de parada
incre = 1 + tol ;
while incre > tol && iter < maxiter
    F=(fx1-fx)/(x1-x0);
    % Expresion del metodo de Newton
    x=x1 -fx1/ F ;
    incre = abs(x-x1);
    I(iter)= incre ;
    % Actualizacion de la estimacion inicial
    dif=(x-x1);
    x0=x1;
    x1=x;
    [fx , dfx ]= feval(f,x0);
    [fx1 , dfx1 ]= feval(f,x1);
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