
sol0=[.1,.1,-.1]';

[sol,iter,incre1,incre2,ACOC]= Jarratt_SENL('SENL',vpa(sol0),1e-12,40);

function [F,dF] = SENL(X)
    x=X(1);
    y=X(2);
    z=X(3);

    F=[3*x+cos(y*z)-1/2; x^2-81*(y+0.1)^2+sin(z)+1.06; exp(-x*y)+20*z-(3-10*pi)/3];
    dF=[3, -z.*sin(y*z), -y.*sin(y*z); 2*x, -162*y-81/5, cos(z); -y.*exp(-x*y), -x.*exp(-x*y), 20]; 
end

function [sol,iter, incre1, incre2,ACOC] = Jarrat_Sist(F,x0,tol,maxit) 
digits(200); 
% Inicializacion de las variables 
iter=0;
incre=tol+1;
incre1=tol+1; 
x0=x0(:); 
[Fx,dFx]=feval(F,x0); 
incre2=norm(Fx);
I=[]
% Criterio de parada 
while incre>tol && iter<maxit
    % Expresion del metodo de Newton 
    y=x0-(2/3)*(dFx\Fx); 
    [Fx,dFy]=feval(F,y);
    x=x0-(1/2)*((3*dFy-dFx)\(3*dFy+dFx))*(dFx\Fx);
    incre1=norm(x-x0); 
    I=[I,incre1];
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

function [sol,iter,incre1,incre2,ACOC] =Jarratt_SENL(F,x0,tol,maxiter)
%[sol,iter,incre1,incre2,ACOC] =Jarratt_SENL('test_3v2',vpa([1 1 2]) ,1e-12 , 40 )
%Jarratt para sistemas, ecuaciones no lineales
digits(200);
iter=0;
incre1=tol+1;
x0=x0(:);
[Fx,dFx]=feval(F,x0);
incre2=norm(Fx);
I=[];
while (incre1+incre2)>tol && iter<maxiter
    %expresion metodo Jrratt
    delta=dFx\Fx;
    y=x0-2/3*delta;
    [~,dFy]=feval(F,y);
    A=3*dFy+dFx;
    u=A*delta;
    B=3*dFy-dFx;
    w=B\u;
    x1=x0-1/2*w;
    incre1=norm(x1-x0);
    I=[I incre1];
    x0=x1;
    [Fx,dFx]=feval(F,x0);
    incre2=norm(Fx);
    iter=iter+1;

end
if length (I) >2
    sol=x1;
    ACOC=log(I(3:end)./I(2:end-1))./log(I(2:end-1)./I(1:end-2));
end

incre1=vpa(incre1,5);
incre2=vpa(incre2,5);
ACOC=vpa(ACOC,7);
sol=vpa(sol,10);

if iter==maxiter
    disp('No se ha obtenido el máximo')

end
end


%{
%[sol,iter,incre1,incre2,ACOC] =Jarratt_SENL('test_3v2',vpa([1 1 2]'),1e-12,50)

function [F,dF] = test_3v (X)
x=X(1);
y=X(2);
z=X(3);
F=[3*x+cos(y*z)-1/2; x^2-81*(y+0.1)^2+sin(z)+1.06;exp(-x*y)+20*z-(3-10*pi)/3];
% primero ejecutar jacobiano y colocar en dF
dF=[3, -z.*sin(y*z), -y.*sin(y*z); 2*x, -162*y-81/5, cos(z); -y.*exp(-x*y), -x.*exp(-x*y), 20]; 
end
%}
