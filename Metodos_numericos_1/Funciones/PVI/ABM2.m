function [t,y] = ABM2(f,a,b,N,ya)
% Código para resolver un PVI con el metodo de
% Adams -Bashfort -Moulton de dos pasos
h=(b-a)/N;
t=a:h:b;
t=t(:) ;
y= zeros(N +1 ,1) ;
y(1) =ya;
% Primer paso con el metodo de Heun
k1 = h* feval (f,t (1) ,y (1) );
k2 = h* feval (f,t (2) ,y (1) +k1);
y (2) = y (1) +( k1+k2) /2;
for k =2: N
% predictor AB2
k1 = feval(f,t(k),y(k));
k2 = feval(f,t(k -1) ,y(k -1) );
yp = y(k)+h/2*(3* k1 -k2);
% corrector AM2
y(k +1) =y(k)+h/2*( feval(f,t(k +1) ,yp)+k1);
end
end
