function [sol,iter, dif,ACOC] = Newton_Sist(F,x0,tol,maxit) 
digits(200); 
% Inicializacion de las variables 
iter=0; incre=tol+1;incre1=tol+1; incre2=tol+1; 
x0=x0(:); 
[Fx,dFx]=feval(F,x0); 
% Criterio de parada 
while incre>tol && iter<maxit
    % Expresion del metodo de Newton 
    x=x0-dFx\Fx; 
    incre1=norm(x-x0); 
    I(iter+1)=incre1; 
    % Actualizacion de la estimacion inicial 
    x0=x; 
    [Fx,dFx]=feval(F,x0); 
    incre2=norm(Fx); 
    % Incremento del contador de iteraciones 
    incre=incre1+incre2;
    iter=iter+1; 
end 
if length(I)>2
    sol=vpa(x,7);
    dif=vpa([incre1,incre2,incre],7);
    ACOC=vpa(log(I(3:end)./I(2:end-1))./log(I(2:end-1)./I(1:end-2)),7);
else
    disp('necesitomasiteraciones')
end
end