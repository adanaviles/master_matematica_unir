function [ai,bi,ci,di,p] = splineCubicoNatural(xi,fi)
    format shortg
    n = length(xi);
    h = zeros(1,n-1);
    for i = 1:n-1
        h(i) = xi(i+1)-xi(i);
    end
    ai  = fi;
    %Relleno la diagonal inferior, superior y principal
    %Relleno también b
    dI = zeros(n-1,1);
    dS = zeros(n-1,1);
    dP = ones(n,1);
    b = zeros(n,1);
    for i = 2:n-1
        dI(i-1) = h(i-1);
        dS(i) = h(i);
        dP(i) = 2*(h(i)+h(i-1));
        b(i) = 3*((ai(i+1)-ai(i))/h(i) - (ai(i)-ai(i-1))/h(i-1));
    end
    % Aplico crout para sacar ci
    ci  = Crout(dP ,dS ,dI ,b);
    bi = zeros(n-1,1);
    di = zeros(n-1,1);
    % Obtengo bi y di
    for i=1:n-1
        bi(i) = (ai(i+1)-ai(i))/h(i) - h(i)*(2*ci(i)+ci(i+1))/3;
        di(i) = (ci(i+1)-ci(i))/(3*h(i));
    end
    
    syms x;
    % En p tendré una lista con cada spline 
    p = zeros(1,n);
    syms p;
    for i = 1:n-1
        p(i) = ai(i)+bi(i)*(x-xi(i))+ci(i)*(x-xi(i))^2+di(i)*(x-xi(i))^3;
    end
end

function x = Crout(dP ,dS ,dI ,b)
    % La función x=Crout(dP,dS,dI,b) obtiene la ...
    % solución del sistema Ax=b utilizando el ...
    % algoritmo de Crout. dP, dS y dI son las ...
    % diagonales principal , superior e inferior de A.
    n = length(dP);
    % 1. Obtención de las matrices L y U tales que A = LU
    l(1) = dP(1);
    u(1) = dS(1)/l(1);
    for i =2:n-1
        l(i) = dP(i)-dI(i-1)*u(i -1) ;
        u(i) = dS(i)/l(i);
    end
    l(n) = dP(n)-dI(n-1)*u(n-1);
    % 2. Solución del sistema Lz = b
   
    z(1) = b(1)/l(1) ;
    for i = 2:n
        z(i) = (1/l(i))*(b(i)-dI(i-1)*z(i-1));
    end
    % 3. Solución del sistema Ux = z
    x(n) = z(n);
    for i = n-1:-1:1
        x(i) = z(i)-u(i)*x(i+1);
    end
    x=x(:);
end