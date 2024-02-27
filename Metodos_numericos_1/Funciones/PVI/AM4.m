function [t,y] = AM4(f,a,b,N,ya)
% Código para resolver un PVI con el metodo de Adams-Moulton de tres pasos
h=(b-a)/N;
t=a:h:b;
t=t(:) ;
y= zeros(N +1 ,1) ;
y(1) =ya;
maxiter =10;
tol =1e-6;
% Primeror dos pasos con el metodo de Runge-Kutta
for k=1:2
    k1=feval(f,t(k),y(k));
    k2=feval(f,t(k)+h/2,y(k)+h*k1/2);
    k3=feval(f,t(k)+h/2,y(k)+h*k2/2);
    k4=feval(f,t(k+1),y(k)+h*k3);
    y(k+1)=y(k)+h*(k1+2*k2+2*k3+k4)/6;
end
% Siguientes pasos con el metodo AM4
for k =3: N
    ff= feval(f,t(k),y(k));
    ff2= feval(f,t(k-2),y(k-2));
    ff1= feval(f,t(k-1),y(k-1));
    % Metodo de Newton
    iter =1; dif = tol +1;
    x0=y(k);
    while and (iter < maxiter ,dif > tol )
        [fx0 , dfx0 ]= feval(f,t(k +1) ,x0);
        g=x0 -y(k)-h/24*(ff2-5*ff1+19*ff+9*fx0);
        dg =1-9*h/24*dfx0 ;
        x1=x0 -g/dg;
        dif = abs(x1 -x0);
        iter = iter +1;
        x0=x1;
    end
    y(k +1) =y(k)+h/24*(ff2-5*ff1+19*ff+9*feval(f,t(k +1) ,x0));
end
end