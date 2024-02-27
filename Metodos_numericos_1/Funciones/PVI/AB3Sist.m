function [t,Y] = AB3Sist(F,a,b,N,Ya)
% Código para resolver un PVI con el metodo de Adams-Bashfort de tres pasos
h=(b-a)/N;
t=a:h:b;
t=t(:) ;
Y= zeros(N+1 ,length(Ya)) ;
Y(1,:) =Ya;
% Primeror tres pasos con el metodo de Runge-Kutta
for k=1:2
    k1=feval(F,t(k),Y(k,:))';
    k2=feval(F,t(k)+h/2,Y(k,:)+h*k1/2)';
    k3=feval(F,t(k)+h/2,Y(k,:)+h*k2/2)';
    k4=feval(F,t(k+1),Y(k,:)+h*k3)';
    Y(k+1,:)=Y(k,:)+h*(k1+2*k2+2*k3+k4)/6;
end
% Siguientes pasos con el metodo AB4
for k =3:N
    k1 = feval(F,t(k),Y(k,:))';
    k2 = feval(F,t(k-1) ,Y(k -1,:) )';
    k3 = feval(F,t(k-2) ,Y(k -2,:) )';
    Y(k+1,:) = Y(k,:)+h/12*(23*k1 -16*k2+5*k3);
end
end