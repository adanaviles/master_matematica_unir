function [t,y] = AB2 (f,a,b,N,ya)
% Código para resolver un PVI con el metodo de ...
%Adams -Bashfort de dos pasos
    h=(b-a)/N;
    t=a:h:b;
    t=t(:);
    y= zeros(N+1 ,1);
    y(1) = ya;
    % Primer paso con el metodo de Heun
    k1 = h*feval(f,t (1),y(1));
    k2 = h*feval(f,t (2),y(1)+k1);
    y(2) = y(1)+(k1+k2) /2;
    % Siguientes pasos con el metodo AB2
    for k =2:N
        k1 = feval(f,t(k),y(k));
        k2 = feval(f,t(k-1) ,y(k -1) );
        y(k +1) = y(k)+h /2*(3* k1 -k2);
    end
end


