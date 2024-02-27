function [t,y] = ABM4(f,a,b,N,ya)
% Código para resolver un PVI con el metodo de
% Adams -Bashfort -Moulton de cuatro pasos
h=(b-a)/N;
t=a:h:b;
t=t(:) ;
y= zeros(N +1 ,1) ;
y(1) =ya;
% Primeror tres pasos con el metodo de Runge-Kutta
for k=1:3
    k1=feval(f,t(k),y(k));
    k2=feval(f,t(k)+h/2,y(k)+h*k1/2);
    k3=feval(f,t(k)+h/2,y(k)+h*k2/2);
    k4=feval(f,t(k+1),y(k)+h*k3);
    y(k+1)=y(k)+h*(k1+2*k2+2*k3+k4)/6;
end
for k =4: N
% predictor AB4
for k =4:N
    k1 = feval(f,t(k),y(k));
    k2 = feval(f,t(k-1) ,y(k -1) );
    k3 = feval(f,t(k-2) ,y(k -2) );
    k4 = feval(f,t(k-3) ,y(k -3) );
    yp = y(k)+h/24*(55*k1 -59*k2+37*k3-9*k4);
    % corrector AM4
    y(k +1) =y(k)+h/24*(k3-5*k2+19*k1+9*feval(f,t(k +1) ,yp));

end
end