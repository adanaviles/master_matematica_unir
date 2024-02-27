function [t,Y] = AM3Sist(F,a,b,N,Ya)
% Código para resolver un PVI con el metodo de Adams-Moulton de dos pasos
h=(b-a)/N;
t=a:h:b;
t=t(:) ;
Y= zeros(N +1 ,length(Ya)) ;
Y(1,:) =Ya;
maxiter =10;
tol =1e-6;
% Primer paso con el metodo de Runge-Kutta
for k=1:1
    k1=feval(F,t(k),Y(k,:))';
    k2=feval(F,t(k)+h/2,Y(k,:)+h*k1/2)';
    k3=feval(F,t(k)+h/2,Y(k,:)+h*k2/2)';
    k4=feval(F,t(k+1),Y(k,:)+h*k3)';
    Y(k+1,:)=Y(k,:)+h*(k1+2*k2+2*k3+k4)/6;
end
% Siguientes pasos con el metodo AM4
for k =2: N
    ff= feval(F,t(k),Y(k,:));
    ff1= feval(F,t(k-1),Y(k-1,:));
    % Metodo de Newton
    iter =1; dif = tol +1;
    x0=Y(k,:)';
    while and (iter < maxiter ,dif > tol )
        disp(t(k+1))
        disp(x0(2))
        [fx0,dfx0]= feval (F,t(k +1) ,x0);
        G=x0 -Y(k,:)'-h/12*(-ff1+8*ff+5*fx0);
        dG =1-h/2*dfx0 ;
        x1=x0 -dG\G;
        dif = norm(x1 -x0,inf);
        iter = iter +1;
        x0=x1;
    end
    Y(k+1,:)=x1';
end
end