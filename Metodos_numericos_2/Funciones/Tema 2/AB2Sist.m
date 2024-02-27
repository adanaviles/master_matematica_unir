function [t,Y] = AB2Sist(F,a,b,N,Ya)
% Código para resolver un PVI con el metodo de Adams-Bashfort de dos pasos
h=(b-a)/N;
t=a:h:b;
t=t(:) ;
Y= zeros(N+1 ,length(Ya)) ;
Y(1,:) =Ya;
% Primer paso con el metodo de Heun
k1 = h* feval(F,t(1) ,Y(1,:) )';
k2 = h* feval (F,t(2) ,Y(1,:) +k1)';
Y(2,:) = Y(1,:) +( k1+k2) /2;
% Siguientes pasos con el metodo AB2
for k =2: N
    k1 = feval(F,t(k),Y(k,:))';
    k2 = feval(F,t(k-1) ,Y(k -1,:) )';
    Y(k+1,:) = Y(k,:)+h/2*(3*k1 -k2);
end
end