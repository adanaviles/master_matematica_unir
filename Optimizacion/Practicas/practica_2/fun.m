function [fx, Dfx] = fun(x)
% En nuestro caso, u0=x
    n = length(x);
    % Como tenemos F definido, podemos calcularlo directamente
    fx_punt = zeros(1,n);
    fx_punt(1) = (1/(2*n))*(x(2)+x(1))*sqrt(1+n^2*(x(2)-x(1))^2);
    fx_punt(end) = (1/(2*n))*(x(end)+x(end-1))*sqrt(1+n^2*(x(end)-x(end-1))^2);
    for i = 1:n-2
        fx_punt(i+1) = (1/(2*n))*(x(i+1)+x(i))*sqrt(1+n^2*(x(i+1)-x(i))^2) + ...
                      (1/(2*n))*(x(i+2)+x(i+1))*sqrt(1+n^2*(x(i+2)-x(i+1))^2);
    end 
    fx = fx_punt;

    % Calculamos ahora el gradiente 
    Dfx_punt = zeros(1,n);
    Dfx_punt(1) = (1/(2*n))*(sqrt(1+(n^2)*(x(2)-x(1))^2)- ...
        (2*n^2*(x(2)-x(1))*(x(2)+x(1)))/sqrt(1+(n^2)*(x(2)-x(1))^2)...
        );
    Dfx_punt(end) = (1/(2*n))*(sqrt(1+n^2*(x(end)-x(end-1))^2)+ ...
        (2*n^2*(x(end)-x(end-1))*(x(end)+x(end-1)))/sqrt(1+n^2*(x(end)-x(end-1))^2)...
        );
    for i = 1:n-2
    Dfx_punt(i+1) = (1/(2*n))*(sqrt(1+n^2*(x(i+1)-x(i))^2)+ ...
        (2*n^2*(x(i+1)-x(i))*(x(i+1)+x(i)))/sqrt(1+n^2*(x(i+1)-x(i))^2)+...
        sqrt(1+n^2*(x(i+2)-x(i+1))^2)-...
        (2*n^2*(x(i+2)-x(i+1))*(x(i+2)+x(i+1)))/sqrt(1+n^2*(x(i+2)-x(i+1))^2));
    end 
    Dfx = Dfx_punt;

end