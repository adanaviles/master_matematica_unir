function [t,Y] = AM2Sist(F,a,b,N,Ya)
% Código para resolver un PVI con el metodo de Adams-Moulton de un paso
h=(b-a)/N;
t=a:h:b;
t=t(:) ;
Y= zeros(N +1 ,length(Ya)) ;
Y(1,:) =Ya;
maxiter =10;
tol =1e-6;
% Primer paso con el metodo de Heun
k1=h* feval(F,t(1) ,Y(1,:) )';
k2=h* feval (F,t(2) ,Y(1,:) +k1)';
Y(2,:) =Y(1,:) +k1/2+ k2/2;
% Siguientes pasos con el metodo AM2
for k =2: N
    ff= feval(F,t(k),Y(k,:));
    % Metodo de Newton
    iter =1; dif = tol +1;
    x0=Y(k,:)';
    while and (iter < maxiter ,dif > tol )
        disp(t(k+1))
        disp(x0(2))
        [fx0,dfx0]= feval (F,t(k +1) ,x0);
        G=x0 -Y(k,:)'-h/2*(fx0 +ff);
        dG =1-h/2*dfx0 ;
        x1=x0 -dG\G;
        dif = norm(x1 -x0,inf);
        iter = iter +1;
        x0=x1;
    end
    Y(k+1,:)=x1';
end
end