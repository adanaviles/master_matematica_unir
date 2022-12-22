function [t,Y] = AB4Sist(F,a,b,N,Ya)
% Código para resolver un PVI con el metodo de Adams-Bashfort de cuatro pasos
h=(b-a)/N;
t=a:h:b;
t=t(:) ;
Y= zeros(N+1 ,length(Ya)) ;
Y(1,:) =Ya;
% Primeror tres pasos con el metodo de Runge-Kutta
for k=1:3
    k1=feval(F,t(k),Y(k,:))';
    k2=feval(F,t(k)+h/2,Y(k,:)+h*k1/2)';
    k3=feval(F,t(k)+h/2,Y(k,:)+h*k2/2)';
    k4=feval(F,t(k+1),Y(k,:)+h*k3)';
    Y(k+1,:)=Y(k,:)+h*(k1+2*k2+2*k3+k4)/6;
end
% Siguientes pasos con el metodo AB4
for k =4:N
    k1 = feval(F,t(k),Y(k,:))';
    k2 = feval(F,t(k-1) ,Y(k -1,:) )';
    k3 = feval(F,t(k-2) ,Y(k -2,:) )';
    k4 = feval(F,t(k-3) ,Y(k -3,:) )';
    Y(k+1,:) = Y(k,:)+h/24*(55*k1 -59*k2+37*k3-9*k4);
end
end