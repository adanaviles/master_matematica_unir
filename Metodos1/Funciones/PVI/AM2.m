function [t,y] = AM2(f,a,b,N,ya)
% Código para resolver un PVI con el metodo de Adams-Moulton de un paso
h=(b-a)/N;
t=a:h:b;
t=t(:) ;
y= zeros(N +1 ,1) ;
y(1) =ya;
maxiter =10;
tol =1e-6;
% Primer paso con el metodo de Heun
k1=h* feval(f,t(1) ,y(1) );
k2=h* feval (f,t(2) ,y(1) +k1);
y(2) =y(1) +k1/2+ k2/2;
% Siguientes pasos con el metodo AM2
for k =2: N
    ff= feval(f,t(k),y(k));
    % Metodo de Newton
    iter =1; dif = tol +1;
    x0=y(k);
    while and (iter < maxiter ,dif > tol )
        [fx0 , dfx0 ]= feval (f,t(k +1) ,x0);
        g=x0 -y(k)-h/2*(fx0 +ff);
        dg =1-h/2*dfx0 ;
        x1=x0 -g/dg;
        dif = abs(x1 -x0);
        iter = iter +1;
        x0=x1;
    end
    y(k +1) =y(k)+h/2*( feval(f,t(k +1) ,x0)+ff);
end
end