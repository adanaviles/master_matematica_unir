function [sol ,iter, incre, f_eval, dif , ACOC ] =TraubNL(f,x0 ,tol , maxiter )
digits (200);
% Inicializacion de las variables
iter =1; 
[fx, dfx]=feval(f,x0);
% Criterio de parada
incre = 1 + tol ;
while incre > tol && iter < maxiter
    % Expresion del metodo de Newton
    y=x0 -fx/ dfx ;
    [fy]=feval(f,y);
    x=y-fy/dfx;
    incre1 = abs(x-x0);
    I(iter)= incre1 ;
    % Actualizacion de la estimacion inicial
    dif=(x-x0);
    x0=x;
    [fx , dfx ]= feval(f,x0);
    % Incremento del contador de iteraciones
    iter = iter +1;
    incre=incre1+abs(fx);
end
if length(I) >2
    sol =vpa(x,7);
    incre1=vpa(incre1,7);
    f_eval=vpa(abs(fx),7);
    dif=vpa(abs(dif),7);
    ACOC = vpa(log(I(3 :end)./I(2 :end -1))./ log(I(2 :end -1)./I(1 :end -2)),7);
else
    disp ('necesito mas iteraciones ')
end
end