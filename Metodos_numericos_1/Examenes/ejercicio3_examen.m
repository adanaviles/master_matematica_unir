
tol=1e-9;
maxiter=50;
[sol ,iter, f_eval, dif , ACOC, I ] =STF2('examen3',vpa(0) ,tol , maxiter );

function [f,df] = examen3(x)
    f=log(x+2)-sqrt(x+1)+x;
    df =1./(x+2)-1/(2*sqrt(x+1))+1;
end


function [sol ,iter, f_eval, dif , ACOC, I ] =STF2(f,x0 ,tol , maxiter )
digits (200);
% Inicializacion de las variables
iter =1;
[fx, dfx]=feval(f,x0);
% Criterio de parada
incre1 = 1 + tol ;
incre2 = norm(fx);
I=[];
while (incre1+incre2) > tol && iter < maxiter
    % Expresion del metodo de Newton
    [f_x]=feval(f,x0+fx);
    yk=x0 -fx.^2/(f_x-fx);
    [fy]=feval(f,yk);
    x=yk -fy.^2/(f_x-fx) ;
    incre1 = abs(x-x0);
    I=[I,incre1];
    % Actualizacion de la estimacion inicial
    dif=(x-x0);
    x0=x;
    [fx , dfx ]= feval(f,x0);
    incre2=norm(fx);
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


function [sol ,iter, f_eval, dif , ACOC, I ] =SteffensenNL(f,x0 ,tol , maxiter )
digits (200);
% Inicializacion de las variables
iter =1;
[fx, dfx]=feval(f,x0);
% Criterio de parada
incre1 = 1 + tol ;
incre2 = norm(fx);
I=[];
while (incre1+incre2) > tol && iter < maxiter
    % Expresion del metodo de Newton
    [f_x]=feval(f,x0+fx);
    x=x0 -fx.^2/(f_x-fx) ;
    incre1 = abs(x-x0);
    I=[I,incre1];
    % Actualizacion de la estimacion inicial
    dif=(x-x0);
    x0=x;
    [fx , dfx ]= feval(f,x0);
    incre2=norm(fx);
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