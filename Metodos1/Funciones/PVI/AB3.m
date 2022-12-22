function [t,y] = AB3(f,a,b,N,ya)
% Código para resolver un PVI con el metodo de Adams-Bashfort de tres pasos
h=(b-a)/N;
t=a:h:b;
t=t(:) ;
y= zeros(N+1 ,1) ;
y(1) =ya;
% Primeror dos pasos con el metodo de Runge-Kutta
for k=1:2
    k1=feval(f,t(k),y(k));
    k2=feval(f,t(k)+h/2,y(k)+h*k1/2);
    k3=feval(f,t(k)+h/2,y(k)+h*k2/2);
    k4=feval(f,t(k+1),y(k)+h*k3);
    y(k+1)=y(k)+h*(k1+2*k2+2*k3+k4)/6;
end
% Siguientes pasos con el metodo AB3
for k =3:N
    k1 = feval(f,t(k),y(k));
    k2 = feval(f,t(k-1) ,y(k -1) );
    k3 = feval(f,t(k-2) ,y(k -2) );
    y(k+1) = y(k)+h/12*(23*k1 -16*k2+5*k3);
end
end